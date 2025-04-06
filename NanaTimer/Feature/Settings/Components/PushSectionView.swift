//
//  PushSectionView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/5/25.
//

import SwiftUI
import Combine

struct PushSectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: State
    
    private let isPushEnabled: Bool
    private let isAuthorized: Bool
    private let isToggleDisabled: Bool
    private let isPickerDisabled: Bool
    private let pushInterval: Int
    private let tintColor: Color
    private let parentIntent: PassthroughSubject<SettingsVM.Intent, Never>
    
    // MARK: Init
    
    init(
        isPushEnabled: Bool,
        isAuthorized: Bool,
        pushInterval: Int,
        tintColor: Color,
        intent: PassthroughSubject<SettingsVM.Intent, Never>
    ) {
        self.isPushEnabled = isPushEnabled
        self.isAuthorized = isAuthorized
        self.isToggleDisabled = !isAuthorized
        self.isPickerDisabled = !(isAuthorized && isPushEnabled)
        self.pushInterval = pushInterval
        self.tintColor = tintColor
        self.parentIntent = intent
    }
    
    // MARK: View
    
    var body: some View {
        
        // MARK: Properties
        
        let isOnBinding = Binding(
            get: { isPushEnabled },
            set: { parentIntent.send(.pushToggleTapped($0)) }
        )
        let selectionBinding = Binding(
            get: { pushInterval },
            set: { parentIntent.send(.pushIntervalSelected($0)) }
        )
        let headerView = Text("알림").bold()
        let footerView = PushSectionFooterView(isAuthorized: isAuthorized) {
            dismiss()
            parentIntent.send(.redirectionButtonTapped)
        }
        
        // MARK: ViewBuilder
        
        Section(header: headerView, footer: footerView) {
            VStack(alignment: .leading) {
                Toggle(isOn: isOnBinding) { Text("타이머 상태 알림") }
                    .tint(tintColor)
                
                Text("타이머 정지를 잊지 않도록 푸시 알림을 받습니다.")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14))
            }
            .listRowBackground(Color.pageIvory)
            .disabled(isToggleDisabled)

            VStack(alignment: .leading) {
                Picker("반복", selection: selectionBinding) {
                    ForEach([30, 60, 90, 120], id: \.self) {
                        Text("\($0)분마다")
                    }
                }
            }
            .listRowBackground(Color.pageIvory)
            .disabled(isPickerDisabled)
        }
    }
}

#Preview {
    SettingsView()
}
