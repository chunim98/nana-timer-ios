//
//  CapsuleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

import ComposableArchitecture

struct CapsuleDismissButton: View {
    
    @ObservedObject var viewStore: ViewStoreOf<Onboarding>
    
    init(_ store: StoreOf<Onboarding>) {
        self.viewStore = ViewStoreOf<Onboarding>(store, observe: { $0 })
    }
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            viewStore.send(.presentAlert)
            
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
            isPresented: viewStore.binding(
                get: { $0.isAlertPresented },
                send: .dismissAlert
            )
        ) {
            Button("취소", role: .cancel) {
                viewStore.send(.dismissAlert)
            }
            Button("닫기") {
                HapticManager.shared.occurLight()
                withAnimation { viewStore.send(.dismissView) }
            }
        }
    }
}

//#Preview {
//    CapsuleDismissButton(OnboardingVM())
//}
