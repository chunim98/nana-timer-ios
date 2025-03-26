//
//  CircleDismissButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

import ComposableArchitecture

struct CircleDismissButton: View {
    
    @ObservedObject var viewStore: ViewStoreOf<Onboarding>
    
    init(_ store: StoreOf<Onboarding>) {
        self.viewStore = ViewStoreOf<Onboarding>(store, observe: { $0 })
    }
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            viewStore.send(.presentAlert)
            
        } label: {
            Image(systemName: "multiply.circle.fill").resizable()
                .foregroundStyle(Color.chuColorPalette[0])
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        
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
//    CircleDismissButton(OnboardingVM())
//}
