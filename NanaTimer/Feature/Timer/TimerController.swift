//
//  TimerController.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI
import Combine

final class TimerController {
    
    struct State {
        @EnumStorage("TimerController.State", TimerState.idle) var state
        @Storage("BackgroundEntryTimeStamp", Date()) var backgroundEntryTimeStamp
        @Storage("InitializedTimeStamp", Date()) var initializedTimeStamp
        @Storage("ElapsedTime", 0) var elapsedTime
        @Storage("Duration", 0) var duration
        var remainingTime: Int { duration - elapsedTime }
    }
    
    enum Intent {
        case configure(Int)  // 타이머 설정 (초 단위)
        case start           // 타이머 시작
        case pause           // 타이머 일시정지
        case resume(Int)     // 백그라운드 진입 후, 타이머 다시 시작
        case complete        // 타이머 완료
        case cancel          // 방치로 인한 타이머 취소
        case enterBackground // 백그라운드 진입
        case enterForeground // 포그라운드 복귀
        case tick            // 매 초 이벤트 발생
        case reset           // 타이머 초기화
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    private weak var timer: Timer?
    
    // MARK: Init
    
    init() {
        intent
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
    }
    
    // MARK: Processing
    
    private func process(_ intent: Intent) {
        switch intent {
        case .configure(let duration):
            state.initializedTimeStamp = Date()
            state.duration = duration
            state.elapsedTime = 0
            state.state = .ready
            
        case .start:
            state.state = .running
            start()
            
        case .pause:
            state.state = .paused
            invalidate()
            
        case .resume(let backgroundElapsedTime):
            state.elapsedTime += backgroundElapsedTime
            // executeTask(.recalculateWeekdayTime)
            state.state = .running
            start()

        case .complete:
            // executeTask(.recalculateWeekdayTimeByTimeover)
            state.state = .finished
            invalidate()
            
        case .cancel:
            state.state = .timeout
            state.elapsedTime = 0
            state.duration = 0
            invalidate()
            
        case .enterBackground:
            guard state.state == .running else { return }
            state.backgroundEntryTimeStamp = Date()
            state.state = .backgrounded
            invalidate()
            
        case .enterForeground:
            handleEnterForeground()

        case .tick:
            state.elapsedTime += 1
            
        case .reset:
            state.elapsedTime = 0
            state.duration = 0
            state.state = .idle
            invalidate()
        }
    }
    
    // MARK: Intent Handle Methods
    
    private func handleEnterForeground() {
        
        /// 1. 백그라운드에서 24시간(86400초) 이상 경과 -> 타임아웃 처리
        /// 2. 타이머가 종료될 만큼 시간이 지남 -> 완료 처리
        /// 3. 백그라운드에서 경과한 시간만큼 반영하여 타이머 재개
        
        guard state.state == .backgrounded else { return }
        
        let elapsed = Int(state.backgroundEntryTimeStamp.distance(to: Date()))
        
        if elapsed >= 86400 {
            intent.send(.cancel) // 1
        } else if elapsed >= state.remainingTime {
            intent.send(.complete) // 2
        } else {
            intent.send(.resume(elapsed)) // 3
        }
    }
    
    // MARK: Timer Handle Methods

    private func start() {
        guard timer == nil else { return }
        
        timer = .scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            self?.intent.send(.tick)
        }
    }
    
    private func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
