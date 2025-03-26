//
//  OnboardingView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 7/1/24.
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {
    
    // MARK: Properties
    
    let store: StoreOf<Onboarding>
    @ObservedObject var viewStore: ViewStoreOf<Onboarding>
    
    // MARK: Init
    
    init() {
        self.store = Store(initialState: Onboarding.State()) { Onboarding() }
        self.viewStore = ViewStoreOf<Onboarding>(self.store, observe: { $0 })
    }
    
    // MARK: View
    
    var body: some View {
        HideableVStack(viewStore.isHidden) {
            
            CircleDismissButton(store)
            
            Spacer()
            
            Text("반가워요!")
                .font(.localizedFont36)
                .foregroundStyle(Color.chuText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 100)
            
            Image(systemName: "hand.point.up.fill").resizable()
                .foregroundStyle(Color.chuText)
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .offset(x: viewStore.imageOffset)
                .animation(.easeInOut(duration: 1.75), value: viewStore.imageOffset)
            
            Spacer().frame(height: 50)
            
            Text("좌우로 밀어서 추가 화면을 볼 수 있어요 :)")
                .font(.localizedFont18)
                .foregroundStyle(Color.chuText)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 50)

            CapsuleDismissButton(store)
            
            Spacer()
        }
        .zIndex(1) // z레이어 우선순위 (높을수록 앞에 옴)
        .padding(15)
        .transition(.opacity)
        .background(.ultraThinMaterial)
        .onAppear { store.send(.onAppear) }
    }
}

#Preview {
    OnboardingView()
}
