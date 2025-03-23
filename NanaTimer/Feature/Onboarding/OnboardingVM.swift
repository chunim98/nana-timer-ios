//
//  OnboardingVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/20/25.
//

import SwiftUI
import Combine

final class OnboardingVM: ObservableObject {
    
    enum Action {
        case presentAlert
        case dismissAlert
        case dismissView
        case timerTick
        case onAppear
    }
    
    // MARK: State
    
    @AppStorage("isHidden") private(set) var isHidden = false
    @Published private(set) var isAlertPresented = false
    @Published private(set) var isImageMoving = true
    @Published private(set) var imageOffset = CGFloat(100)
    
    // MARK: Properties
    
    let action = PassthroughSubject<Action, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var animationTimer: Timer?

    // MARK: Life Cycle
    
    init() {
        action
            .sink { [weak self] in self?.bindActions($0) }
            .store(in: &cancellables)
    }
    
    // MARK: Binding
    
    private func bindActions(_ action: Action) {
        switch action {
        case .presentAlert:
            isAlertPresented = true
            
        case .dismissAlert:
            isAlertPresented = false
            
        case .dismissView:
            isHidden = true
            timerInactivate()
            
        case .timerTick:
            isImageMoving.toggle()
            imageOffset *= -1
            
        case .onAppear:
            timerActivate()
        }
    }
    
    // MARK: Methods
    
    private func timerActivate() {
        animationTimer = Timer.scheduledTimer(
            withTimeInterval: 2,
            repeats: true,
            block: { [weak self] _ in self?.action.send(.timerTick) }
        )
    }
    
    private func timerInactivate() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
}
