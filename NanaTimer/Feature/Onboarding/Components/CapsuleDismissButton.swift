//
//  CapsuleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI
import Combine

struct CapsuleDismissButton: View {
    
    // MARK: Properties
    
    private let isAlertPresented: Bool
    private let intent: PassthroughSubject<OnboardingVM.Intent, Never>
    
    // MARK: Initalizer
    
    init(
        isAlertPresented: Bool,
        intent: PassthroughSubject<OnboardingVM.Intent, Never>
    ) {
        self.isAlertPresented = isAlertPresented
        self.intent = intent
    }
    
    // MARK: View
    
    var body: some View {
        // Properties
        let isPresentedBinding = Binding(
            get: { isAlertPresented },
            set: { _ in }
        )
        
        // View
        Button {
            HapticManager.shared.occurLight()
            intent.send(.presentAlert)
            
        } label: {
            Text("닫기")
                .font(.localizedFont28)
                .foregroundStyle(Color.init(hex: 0xefedeb))
        }
        .padding(EdgeInsets(horizontal: 15, vertical: 7.5))
        .background {
            RoundedRectangle(cornerRadius: .greatestFiniteMagnitude)
                .fill(Color.textBlack)
        }
        .alert(
            "창을 닫을까요?\n이 창은 다시 볼 수 없어요",
            isPresented: isPresentedBinding
        ) {
            Button("취소", role: .cancel) {
                intent.send(.dismissAlert)
            }
            
            Button("닫기") {
                HapticManager.shared.occurLight()
                withAnimation { intent.send(.dismissView) }
            }
        }
    }
}

#Preview {
    CapsuleDismissButton(isAlertPresented: false, intent: .init())
}
