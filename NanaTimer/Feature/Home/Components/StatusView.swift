//
//  StatusView.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/29/25.
//

import SwiftUI
import Combine

struct StatusView: View {
    
    // MARK: Properties
    
    private let titleText: LocalizedStringKey
    private let subTitleText: LocalizedStringKey
    private let intent: PassthroughSubject<HomeVM.Intent, Never>
    
    // MARK: Initializer
    
    init(
        pageIndex: Int,
        timerState: TimerState,
        intent: PassthroughSubject<HomeVM.Intent, Never>
    ) {
        if pageIndex == 0 {
            self.titleText = switch timerState {
            case .idle : "안녕하세요!"
            case .ready: "준비됐나요?"
            case .running: "힘내세요!"
            case .paused: "쉬었다 갈게요!"
            case .finished: "끝! 고생 많았어요."
            default: ""
            }
            self.subTitleText = ""
            
        } else { // 페이지 인덱스가 1일 경우
            self.titleText = "공부 현황"
            self.subTitleText = "단위 (분)"
        }
        
        self.intent = intent
    }
    
    // MARK: View
    
    var body: some View {
        HStack {
            // 타이틀 텍스트
            Text(titleText)
                .font(.localizedFont28)
                .foregroundStyle(Color.textBlack)
            
            // 서브타이틀 텍스트
            Text(subTitleText)
                .font(.localizedFont14)
                .foregroundStyle(Color.textGray)
            
            Spacer()
            
            // 설정 화면으로 이동 버튼
            Button {
                intent.send(.settingsButtonTapped)
                
            } label: {
                Image(systemName: "gearshape.fill").resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.textBlack)
            }
        }
        .frame(height: 34)
        .padding(.horizontal, 15)
    }
}

#Preview {
    HomeView()
}
