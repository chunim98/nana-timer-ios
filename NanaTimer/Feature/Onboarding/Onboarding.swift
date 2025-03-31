//
//  Onboarding.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/20/25.
//

import SwiftUI
import Combine

final class Onboarding: ObservableObject {
        
    struct State {
        @BoolStorage("isHidden") var isHidden: Bool
        var isAlertPresented = false
        var imageOffset = CGFloat(100)
    }
    
    enum Intent {
        case presentAlert
        case dismissAlert
        case dismissView
        case timerTick
        case onAppear
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var animationTimer: Timer?

    // MARK: Life Cycle
    
    init() {
        intent
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
    }
    
    // MARK: Binding
    
    private func process(_ intent: Intent) {
        switch intent {
        case .presentAlert:
            state.isAlertPresented = true
            
        case .dismissAlert:
            state.isAlertPresented = false
            
        case .dismissView:
            state.isHidden = true
            timerInactivate()
            
        case .timerTick:
            state.imageOffset *= -1
            
        case .onAppear:
            timerActivate()
        }
    }
    
    // MARK: Methods
    
    private func timerActivate() {
        animationTimer = Timer.scheduledTimer(
            withTimeInterval: 2,
            repeats: true,
            block: { [weak self] _ in self?.intent.send(.timerTick) }
        )
    }
    
    private func timerInactivate() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
}
