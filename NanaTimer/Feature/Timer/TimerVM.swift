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
        @EnumStorage("SS", TimerScreenState.entry) var screenState
        var dailyStudyTimes = [Int](repeating: 0, count: 7+1)
        let colors = Color.chuColorPalette.shuffled()
        var timerState = TimerState.idle
        var remainingTime = 0
        var elapsedTime = 0
        var duration = 0
    }
    
    enum Intent {
        case setupButtonTapped
        case closeSetupViewButtonTapped
        case confirmButtonTapped(Int)
        case controlButtonTapped
        case resetAlertAccepted
        case scenePhaseUpdated(ScenePhase)
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let timer = TimerController()
    
    // MARK: Init
    
    init() {
        intent // 인텐트 바인딩
            .print("타이머 뷰모델")
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
        
        timer.$state // 타이머 상태 바인딩
            .sink { [weak self] in
                guard let self else { return }
                state.dailyStudyTimes = $0.dailyStudyTimes
                state.timerState = $0.timerState
                state.duration = $0.duration
                state.elapsedTime = $0.elapsed
                state.remainingTime = $0.remaining
            }
            .store(in: &cancellables)
    }
    
    // MARK: Processing
    
    private func process(_ intent: Intent) {
        switch intent {
        case .setupButtonTapped:
            state.screenState = .setup
            
        case .closeSetupViewButtonTapped:
            state.screenState = .entry
            
        case let .confirmButtonTapped(duration):
            timer.intent.send(.configure(duration))
            state.screenState = .main
            
        case .controlButtonTapped:
            handleControlButtonTapped()
            
        case .resetAlertAccepted:
            timer.intent.send(.reset)
            state.screenState = .entry
            
        case let .scenePhaseUpdated(scenePhase):
            handleScenePhaseUpdated(scenePhase)
        }
    }
    
    // MARK: Methods
    
    /// 컨트롤 버튼의 탭 이벤트가 발생해, 타이머에 상태를 변경할 것을 요청합니다.
    private func handleControlButtonTapped() {
        switch state.timerState {
        case .ready, .paused:
            timer.intent.send(.start)
        case .running:
            timer.intent.send(.pause)
        default:
            break
        }
    }
    
    /// 앱 상태가 변경되어, 타이머에 상태를 변경할 것을 요청합니다.
    private func handleScenePhaseUpdated(_ scenePhase: ScenePhase) {
        if scenePhase == .active {
            timer.intent.send(.enterForeground)
        } else if scenePhase == .background {
            timer.intent.send(.enterBackground)
        }
    }
}
