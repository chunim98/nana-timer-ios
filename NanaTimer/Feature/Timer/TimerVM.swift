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
        @EnumStorage("AppState", AppState.active)
        var appState //
        
        @EnumStorage("SetupState", SetupState.notConfigured)
        var setupState // 어떤 화면을 보여줄지에 대해 관여
        
        @EnumStorage("TimerState", TimerState.idle)
        var timerState //
        
        @Storage("Duration", 0) var duration
        @Storage("ElapsedTime", 0) var elapsedTime
        let colors = Color.chuColorPalette.shuffled()
        
        var remainingTime: Int { duration - elapsedTime }
    }
    
    enum Intent {
        case setupButtonTapped
        case closeSetupViewButtonTapped
        case confirmButtonTapped(Int)
        case timerTick
        case controlButtonTapped
        case resetAlertAccepted
        case scenePhaseUpdated(ScenePhase)
        case timerStateUpdateRequested(TimerState)
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let timer = TimerHelper()

    // MARK: Life Cycle
    
    init() {
        timer.perform = { [weak self] in
            self?.intent.send(.timerTick)
        }
        
        intent // 인텐트 바인딩
            .print("TimerVM")
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
    }

    // MARK: Processing
    
    private func process(_ intent: Intent) {
        switch intent {
        case .setupButtonTapped:
            state.setupState = .configuring
            
        case .closeSetupViewButtonTapped:
            state.setupState = .notConfigured
            
        case let .confirmButtonTapped(duration):
            state.duration = duration
            state.setupState = .configured
            updateTimerState(.ready)
            
        case .timerTick:
            state.elapsedTime += 1
            if state.remainingTime <= 0 { updateTimerState(.finished) }
            
        case .controlButtonTapped:
            requestTimerStateUpdate()
            
        case .resetAlertAccepted:
            state.setupState = .notConfigured
            updateTimerState(.idle)
            
        case let .scenePhaseUpdated(scenePhase):
            state.appState = scenePhase.appState
            
        case let .timerStateUpdateRequested(timerState):
            updateTimerState(timerState)
        }
    }
    
    // MARK: Methods
    
    /// 타이머의 상태를 변경할 것을 요청합니다.
    private func requestTimerStateUpdate() {
        switch state.timerState {
        case .ready, .paused:
            intent.send(.timerStateUpdateRequested(.running))

        case .running:
            intent.send(.timerStateUpdateRequested(.paused))

        default:
            break
        }
    }
    
    /// 타이머의 상태를 업데이트 하고, 뒤이어 TimerMainView의 상태도 업데이트 합니다.
    private func updateTimerState(_ state: TimerState) {
        self.state.timerState = state
        
        // 각 상태별로 TimerMainView는 어떤 상태여야 하는지 명세
        switch state {
        case .idle:
            timer.invalidate()
            self.state.elapsedTime = 0
            self.state.duration = 0

        case .ready:
            timer.invalidate()
            
        case .running:
            timer.start()
            
        case .paused:
            timer.invalidate()
            
        case .backgrounded:
            timer.invalidate()
            
        case .finished:
            timer.invalidate()
        }
    }
}
