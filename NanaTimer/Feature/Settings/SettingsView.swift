//
//  SettingsView.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var vm = SettingsVM()
    
    var body: some View {
        List {
            // 푸시 알림 섹션
            PushSectionView(
                isPushEnabled: vm.state.isPushEnabled,
                isAuthorized: vm.state.isAuthorized,
                pushInterval: vm.state.pushInterval,
                tintColor: vm.state.tintColor,
                intent: vm.intent
            )
            
            // 기타 섹션
            ECTSectionView(
                isHapticPulseEnabled: vm.state.isHapticPulseEnabled,
                tintColor: vm.state.tintColor,
                intent: vm.intent
            )
        }
        .background { Color.backgroundBeige.ignoresSafeArea() }
        .onAppear { vm.intent.send(.viewOnAppear) }
        .scrollContentBackground(.hidden)
        
        // 네비게이션 바 설정
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("설정")
    }
}

#Preview {
    SettingsView()
}
