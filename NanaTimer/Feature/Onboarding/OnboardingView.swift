//
//  OnboardingView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 7/1/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var onboardingVM = OnboardingVM()
    
    var body: some View {
        HideableVStack(onboardingVM.isHidden) {
            
            CircleDismissButton(onboardingVM)
            
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
                .offset(x: onboardingVM.imageOffset)
                .animation(.easeInOut(duration: 1.75), value: onboardingVM.imageOffset)
            
            Spacer().frame(height: 50)
            
            Text("좌우로 밀어서 추가 화면을 볼 수 있어요 :)")
                .font(.localizedFont18)
                .foregroundStyle(Color.chuText)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 50)

            CapsuleDismissButton(onboardingVM)
            
            Spacer()
        }
        .zIndex(1) // z레이어 우선순위 (높을수록 앞에 옴)
        .padding(15)
        .background(.ultraThinMaterial)
        .onAppear { onboardingVM.action.send(.onAppear) }
    }
}

#Preview {
    OnboardingView()
}
