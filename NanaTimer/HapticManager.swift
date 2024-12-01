//
//  HapticManager.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/12/24.
//

import SwiftUI

final class HapticManager {
    static let shared = HapticManager()
    
    private let ligthFeedback = UIImpactFeedbackGenerator(style: .light)
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
    private let successFeedback = UINotificationFeedbackGenerator()
    private let selectFeedback = UISelectionFeedbackGenerator()
    
    
    private init() {}
    
    func occurLight() {
        ligthFeedback.impactOccurred()
    }
    
    func occurRigid() {
        rigidFeedback.impactOccurred(intensity: 0.75)
    }
    
    func occurSuccess() {
        successFeedback.notificationOccurred(.success)
    }
    
    func occurSelect() {
        selectFeedback.selectionChanged()
    }
    
}

