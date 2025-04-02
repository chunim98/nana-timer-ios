//
//  ScenePhase+.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import SwiftUI

extension ScenePhase {
    var appState: AppState {
        switch self {
        case .background:
            AppState.background
            
        case .inactive:
            AppState.inactive
            
        case .active:
            AppState.active
            
        @unknown default:
            AppState.unknown
        }
    }
}
