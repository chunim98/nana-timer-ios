//
//  CircleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

struct CircleDismissButton: View {
    
    @ObservedObject private var onboardingVM: OnboardingVM
    
    init(_ onboardingVM: OnboardingVM) {
        self.onboardingVM = onboardingVM
    }
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            onboardingVM.action.send(.presentAlert)
            
        } label: {
            Image(systemName: "multiply.circle.fill").resizable()
                .foregroundStyle(Color.chuColorPalette[0])
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        
        .alert(
            "창을 닫을까요?\n이 창은 다시 볼 수 없어요",
            isPresented: Binding(get: { onboardingVM.isAlertPresented }, set: { _,_ in })
        ) {
            Button("취소", role: .cancel) {
                onboardingVM.action.send(.dismissAlert)
            }
            Button("닫기") {
                HapticManager.shared.occurLight()
                withAnimation {
                    onboardingVM.action.send(.dismissView)
                    
                } completion: {
                    // onboardingVM.animationTimer?.invalidate()
                    // onboardingVM.animationTimer = nil
                }
            }
        }
    }
}

#Preview {
    CircleDismissButton(OnboardingVM())
}
