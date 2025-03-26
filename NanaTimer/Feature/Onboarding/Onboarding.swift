//
//  Onboarding.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/26/25.
//

import Foundation

import ComposableArchitecture

struct Onboarding: Reducer {
    
    struct State: Equatable {
        var isHidden = false
        var isAlertPresented = false
        var imageOffset = CGFloat(100)
    }
    
    enum Action: Equatable {
        case presentAlert
        case dismissAlert
        case dismissView
        case timerTick
        case onAppear
    }
        
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .presentAlert:
                state.isAlertPresented = true
                return .none
                
            case .dismissAlert:
                state.isAlertPresented = false
                return .none
                
            case .dismissView:
                state.isHidden = true
                return .cancel(id: "timer")
                
            case .timerTick:
                state.imageOffset *= -1
                return .none
                
            case .onAppear:
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(2))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: "timer")
            }
        }
    }
}
