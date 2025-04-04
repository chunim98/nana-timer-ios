//
//  OnboardingView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 7/1/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var vm = Onboarding()
    
    var body: some View {
        HideableVStack(vm.state.isHidden) {
            CircleDismissButton(vm)
            
            Spacer()
            
            Text("반가워요!")
                .font(.localizedFont36)
                .foregroundStyle(Color.textBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 100)
            
            Image(systemName: "hand.point.up.fill").resizable()
                .foregroundStyle(Color.textBlack)
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .offset(x: vm.state.imageOffset)
                .animation(
                    .easeInOut(duration: 1.75),
                    value: vm.state.imageOffset
                )
            
            Spacer().frame(height: 50)
            
            Text("좌우로 밀어서 추가 화면을 볼 수 있어요 :)")
                .font(.localizedFont18)
                .foregroundStyle(Color.textBlack)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 50)

            CapsuleDismissButton(vm)
            
            Spacer()
        }
        .padding(15)
        .transition(.opacity)
        .background(.ultraThinMaterial)
        .onAppear { vm.intent.send(.onAppear) }
    }
}

#Preview {
    OnboardingView()
}
