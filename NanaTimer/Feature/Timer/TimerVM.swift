//
//  TimerVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/31/25.
//

import SwiftUI
import Combine

final class TimerVM: ObservableObject {
    
    struct State {
        @Storage("DST", [Int](repeating: 0, count: 7+1)) var dailyStudyTimes
        @EnumStorage("SS", TimerScreenState.entry) var screenState
        @EnumStorage("TS", TimerState.idle) var timerState
        @Storage("BEA", Date()) var backgroundEnterAt
        @Storage("IA", Date()) var initializedAt
        @Storage("D", 0) var duration
        @Storage("E", 0) var elapsed
        var remaining: Int { duration - elapsed }
        let colors = Color.palette.shuffled()
        
        /// 설정 값 읽어오기 전용
        @Storage("S.IHPE", false) private(set) var isHapticPulseEnabled
    }
    
    enum Intent {
        case setupButtonTapped
        case closeSetupViewButtonTapped
        case confirmButtonTapped(Int)
        case controlButtonTapped
        case resetAlertAccepted
        case scenePhaseUpdated(ScenePhase)
    }
    
    /// 타이머 컨트롤 이벤트
    private enum TimerIntent {
        case configure(Int)            // 타이머 설정 (초 단위)
        case start                     // 타이머 시작
        case pause                     // 타이머 일시정지
        case resume(Int)               // 백그라운드 진입 후, 타이머 다시 시작
        case complete                  // 타이머 완료
        case completeInBackGround(Int) // 백그라운드 상태에서 타이머 완료
        case cancel                    // 방치로 인한 타이머 취소
        case enterBackground           // 백그라운드 진입
        case enterForeground           // 포그라운드 복귀
        case tick                      // 매 초 이벤트 발생
        case reset                     // 타이머 초기화
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private let timerIntent = PassthroughSubject<TimerIntent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let calendar = Calendar.current
    private weak var timer: Timer?

    // MARK: Init
    
    init() {
        intent // 인텐트 바인딩
            .print("타이머 뷰모델")
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
        
        timerIntent // 타이머 컨트롤 인텐트 바인딩
            .sink { [weak self] in self?.timerProcess($0) }
            .store(in: &cancellables)
    }
    
    // MARK: Intent Processing
    
    private func process(_ intent: Intent) {
        switch intent {
        case .setupButtonTapped:
            state.screenState = .setup
            
        case .closeSetupViewButtonTapped:
            state.screenState = .entry
            
        case let .confirmButtonTapped(duration):
            timerIntent.send(.configure(duration))
            state.screenState = .main
            
        case .controlButtonTapped:
            handleControlButtonTapped()
            
        case .resetAlertAccepted:
            timerIntent.send(.reset)
            state.screenState = .entry
            
        case let .scenePhaseUpdated(scenePhase):
            handleScenePhaseUpdated(scenePhase)
        }
    }
    
    // MARK: Timer Intent Processing
    
    private func timerProcess(_ intent: TimerIntent) {
        switch intent {
        case .configure(let duration):
            state.dailyStudyTimes = [Int](repeating: 0, count: 7+1)
            state.initializedAt = Date()
            state.timerState = .ready
            state.duration = duration
            state.elapsed = 0
            
        case .start:
            state.timerState = .running
            start()
            
        case .pause:
            state.timerState = .paused
            invalidate()
            
        case .resume(let elapsedInBG):
            updateDailyStudyTimes(elapsedInBG, Date())
            state.elapsed += elapsedInBG
            state.timerState = .running
            start()

        case .complete:
            state.elapsed = state.duration
            state.timerState = .finished
            invalidate()
            
        case .completeInBackGround(let elapsedInBG):
            updateDailyStudyTimes(
                elapsedInBG,
                Date()+TimeInterval(state.remaining)
            )
            state.elapsed = state.duration
            state.timerState = .finished
            invalidate()

        case .cancel:
            state.dailyStudyTimes = [Int](repeating: 0, count: 7+1)
            state.timerState = .timeout
            state.screenState = .entry
            state.duration = 0
            state.elapsed = 0
            invalidate()
            
        case .enterBackground:
            guard state.timerState == .running else { return }
            state.timerState = .backgrounded
            state.backgroundEnterAt = Date()
            invalidate()
            
        case .enterForeground:
            handleEnterForeground()

        case .tick:
            handleTick()
            
        case .reset:
            state.dailyStudyTimes = [Int](repeating: 0, count: 7+1)
            state.timerState = .idle
            state.duration = 0
            state.elapsed = 0
            invalidate()
        }
    }
    
    // MARK: Intent Handle Methods

    /// 컨트롤 버튼의 탭 이벤트가 발생해, 타이머에 상태를 변경할 것을 요청합니다.
    private func handleControlButtonTapped() {
        switch state.timerState {
        case .ready, .paused:
            timerIntent.send(.start)
        case .running:
            timerIntent.send(.pause)
        default:
            break
        }
    }
    
    /// 앱 상태가 변경되어, 타이머에 상태를 변경할 것을 요청합니다.
    private func handleScenePhaseUpdated(_ scenePhase: ScenePhase) {
        if scenePhase == .active {
            timerIntent.send(.enterForeground)
        } else if scenePhase == .background {
            timerIntent.send(.enterBackground)
        }
    }
    
    private func handleEnterForeground() {
        
        /// 1. 백그라운드에서 24시간(86400초) 이상 경과 -> 타임아웃 처리
        /// 2. 타이머가 종료될 만큼 시간이 지남 -> 완료 처리
        /// 3. 백그라운드에서 경과한 시간만큼 반영하여 타이머 재개
        
        guard state.timerState == .backgrounded else { return }
        
        let elapsedInBG = Int(state.backgroundEnterAt.distance(to: Date()))
        
        if elapsedInBG >= 10 {
            timerIntent.send(.cancel) // 1
        } else if elapsedInBG >= state.remaining {
            timerIntent.send(.completeInBackGround(elapsedInBG)) // 2
        } else {
            timerIntent.send(.resume(elapsedInBG)) // 3
        }
    }
    
    private func handleTick() {
        let weekday = calendar.component(.weekday, from: Date())
        state.dailyStudyTimes[weekday] += 1
        state.elapsed += 1
        
        if state.isHapticPulseEnabled { HapticManager.shared.occurRigid() }
        if state.elapsed >= state.duration { timerIntent.send(.complete) }
    }
    
    private func updateDailyStudyTimes(
        _ elapsedInBG: Int,
        _ referenceTime: Date
    ) {
        
        /// 백그라운드에서 경과된 시간이 남은 시간보다 큰 경우, referenceTime은 타이머 종료 예정 시간으로 설정.
        /// 백그라운드에서 경과된 시간이 남은 시간보다 작은 경우, referenceTime은 현재 시간으로 설정.
        
        let reference = calendar.getSmallComponent(referenceTime)
        let bgEnterAt = calendar.getSmallComponent(state.backgroundEnterAt)
        
        if bgEnterAt.weekday != reference.weekday {
            // 날짜가 변경된 경우, 이전 날짜와 현재 날짜의 시간을 보정
            state.dailyStudyTimes[reference.weekday] += reference.totalSeconds
            state.dailyStudyTimes[bgEnterAt.weekday] += (elapsedInBG-reference.totalSeconds)
        } else {
            // 같은 요일 내에서 경과 시간만 반영
            state.dailyStudyTimes[reference.weekday] += elapsedInBG
        }
    }
    
    // MARK: Timer Handle Methods

    private func start() {
        guard timer == nil else { return }
        
        timer = .scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            self?.timerIntent.send(.tick)
        }
    }
    
    private func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
