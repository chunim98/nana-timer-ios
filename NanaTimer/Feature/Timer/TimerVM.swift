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
        let colors = Color.chuColorPalette.shuffled()
        // @IntStorage("setupState", 0) var setupState: Int
        var setupState: SetupState = .notConfigured
        var timerState: TimerState = .idle
        var duration = 0
        var elapsedTime = 0
        
        var remainingTime: Int { duration - elapsedTime }
    }
    
    enum Intent {
        case setupButtonTapped
        case closeSetupViewButtonTapped
        case confirmButtonTapped(Int)
        case timerTick
        case controlButtonTapped
        case resetAlertAccepted
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
            state.timerState = .ready
            
        case .timerTick:
            state.elapsedTime += 1
            if state.remainingTime < 0 { timer.invalidate() }
            
        case .controlButtonTapped:
            updateTimerState()
            
        case .resetAlertAccepted:
            timer.invalidate()
            state.timerState = .idle
            state.setupState = .notConfigured
        }
    }
    
    // MARK: Methods
    
    private func updateTimerState() {
        switch state.timerState {
        case .ready, .paused:
            state.timerState = .running
            timer.start()
            
        case .running:
            state.timerState = .paused
            timer.invalidate()
            
        default:
            break
        }
    }
}
