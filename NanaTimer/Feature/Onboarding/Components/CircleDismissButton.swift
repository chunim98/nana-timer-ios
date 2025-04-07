//
//  CircleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI
import Combine

struct CircleDismissButton: View {
    
    // MARK: Properties
    
    private let isAlertPresented: Bool
    private let intent: PassthroughSubject<OnboardingVM.Intent, Never>
    
    // MARK: Initializer
    
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
            Image(systemName: "multiply.circle.fill").resizable()
                .foregroundStyle(Color.textBlack)
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
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
    CircleDismissButton(isAlertPresented: false, intent: .init())
}
