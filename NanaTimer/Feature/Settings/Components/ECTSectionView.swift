//
//  ECTSectionView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/5/25.
//

import SwiftUI
import Combine

struct ECTSectionView: View {
    
    // MARK: Properties
    
    private let isHapticPulseEnabled: Bool
    private let tintColor: Color
    private let intent: PassthroughSubject<SettingsVM.Intent, Never>
    
    // MARK: Initializer
    
    init(
        isHapticPulseEnabled: Bool,
        tintColor: Color,
        intent: PassthroughSubject<SettingsVM.Intent, Never>
    ) {
        self.isHapticPulseEnabled = isHapticPulseEnabled
        self.tintColor = tintColor
        self.intent = intent
    }
    
    // MARK: View
    
    var body: some View {
        // Properties
        let isHapticPulseEnabledBinding = Binding(
            get: { isHapticPulseEnabled },
            set: { intent.send(.hapticPulseToggled($0)) }
        )
        let headerView = Text("기타").bold()
        
        // View
        Section(header: headerView) {
            VStack(alignment: .leading) {
                Toggle(isOn: isHapticPulseEnabledBinding) { Text("촉각 피드백") }
                    .tint(tintColor)
                
                Text("타이머 작동 중 매초 햅틱 피드백이 발생합니다.")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14))
            }
            .listRowBackground(Color.pageIvory)
        }
    }
}

#Preview {
    ECTSectionView(
        isHapticPulseEnabled: true,
        tintColor: .blue,
        intent: .init()
    )
}
