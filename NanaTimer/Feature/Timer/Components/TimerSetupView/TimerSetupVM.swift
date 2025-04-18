//
//  TimerSetupVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI
import Combine

final class TimerSetupVM: ObservableObject {
    
    // MARK: State & Intent
    
    struct State {
        let tintColor = Color.palette.randomElement()!
        let hours = Array(0..<112)
        let minutes = Array(stride(from: 0, through: 50, by: 10))
        var hourSelection = 1
        var minuteSelection = 0
        
        var isConfirmButtonDiabled: Bool { hourSelection == 0 && minuteSelection == 0 }
        var selectionSum: Int { hourSelection.hourToSec + minuteSelection.minToSec }
    }
    
    enum Intent {
        case hourPickerSwiped(Int)
        case minutePickerSwiped(Int)
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Initializer (Intent Binding)
    
    init() {
        intent
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
    }
    
    // MARK: Intent Handling
    
    private func process(_ intent: Intent) {
        switch intent {
        case let .hourPickerSwiped(hour):
            state.hourSelection = hour
            
        case let .minutePickerSwiped(minute):
            state.minuteSelection = minute
        }
    }
}
