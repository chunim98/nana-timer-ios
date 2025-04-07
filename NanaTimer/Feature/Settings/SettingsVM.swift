//
//  SettingsVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/5/25.
//

import SwiftUI
import Combine

final class SettingsVM: ObservableObject {
    
    // MARK: State & Intent
    
    struct State {
        @Storage("S.IHPE", false) var isHapticPulseEnabled: Bool
        @Storage("S.IPE", true) var isPushEnabled: Bool
        @Storage("S.IA", false) var isAuthorized: Bool
        @Storage("S.PI", 60) var pushInterval: Int
        let tintColor = Color.palette.randomElement()!
    }
    
    enum Intent {
        case pushToggleTapped(Bool)
        case pushIntervalSelected(Int)
        case hapticPulseToggled(Bool)
        case viewOnAppear
        case redirectionButtonTapped
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Initializer
    
    init() {
        intent
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
    }
    
    // MARK: Intent Handling
    
    private func process(_ intent: Intent) {
        switch intent {
        case .pushToggleTapped(let isEnabled):
            state.isPushEnabled = isEnabled
            
        case .pushIntervalSelected(let interval):
            state.pushInterval = interval
            
        case .hapticPulseToggled(let isEnabled):
            state.isHapticPulseEnabled = isEnabled
            
        case .viewOnAppear:
            checkAuthorization()
            
        case .redirectionButtonTapped:
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: Methods
    
    private func checkAuthorization() {
        Task { @MainActor in
            let settings = await PushNotificationManager.shared.getNotificationSettings()
            state.isAuthorized = settings.authorizationStatus == .authorized
        }
    }
}
