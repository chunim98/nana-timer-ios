//
//  StatusView.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/29/25.
//

import SwiftUI
import Combine

struct StatusView: View {
    
    private let titleText: LocalizedStringKey
    private let subTitleText: LocalizedStringKey
    private let intent: PassthroughSubject<Home.Intent, Never>

    init(
        _ pageIndex: Int,
        _ timerState: TimerModel.State,
        _ intent: PassthroughSubject<Home.Intent, Never>
    ) {
        self.intent = intent
        
        if pageIndex == 0 {
            self.titleText = timerState.titleText
            self.subTitleText = ""
            
        } else { // 페이지 인덱스가 1일 경우
            self.titleText = "단위 (분)"
            self.subTitleText = "공부 현황"
        }
    }
    
    var body: some View {
        HStack {
            // 타이틀 텍스트
            Text(titleText)
                .font(.localizedFont28)
                .foregroundColor(Color.chuText)
            
            // 서브타이틀 텍스트
            Text(subTitleText)
                .font(.localizedFont14)
                .foregroundColor(Color.chuText.opacity(0.5))
            
            Spacer()
            
            // 설정 화면으로 이동 버튼
            Button {
                intent.send(.settingsButtonTapped)
                
            } label: {
                Image(systemName: "gearshape.fill").resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.chuText)
            }
        }
        .frame(height: 34)
        .padding(.horizontal, 15)
    }
}

#Preview {
    HomeView(homeVM: .init(), timerVM: .init(), chartVM: .init())
}
