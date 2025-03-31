//
//  CapsuleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

struct CapsuleDismissButton: View {
    
    @ObservedObject private var onboardingVM: Onboarding
    
    init(_ onboardingVM: Onboarding) {
        self.onboardingVM = onboardingVM
    }
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            onboardingVM.intent.send(.presentAlert)
            
        } label: {
            Text("닫기")
                .font(.localizedFont28)
                .foregroundColor(Color.init(hex: 0xefedeb))
        }
        .padding(EdgeInsets(horizontal: 15, vertical: 7.5))
        .background {
            RoundedRectangle(cornerRadius: .greatestFiniteMagnitude)
                .fill(Color.chuColorPalette[0])
        }
        
        .alert(
            "창을 닫을까요?\n이 창은 다시 볼 수 없어요",
            isPresented: Binding(get: { onboardingVM.state.isAlertPresented }, set: { _,_ in })
        ) {
            Button("취소", role: .cancel) {
                onboardingVM.intent.send(.dismissAlert)
            }
            Button("닫기") {
                HapticManager.shared.occurLight()
                withAnimation { onboardingVM.intent.send(.dismissView) }
            }
        }
    }
}

#Preview {
    CapsuleDismissButton(Onboarding())
}
