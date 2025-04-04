//
//  CircleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

struct CircleDismissButton: View {
    
    @ObservedObject private var onboardingVM: Onboarding
    
    init(_ onboardingVM: Onboarding) {
        self.onboardingVM = onboardingVM
    }
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            onboardingVM.intent.send(.presentAlert)
            
        } label: {
            Image(systemName: "multiply.circle.fill").resizable()
                .foregroundStyle(Color.palette[0])
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        
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
    CircleDismissButton(Onboarding())
}
