//
//  TimerEntryView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/3/25.
//

import SwiftUI
import Combine

struct TimerEntryView: View {
    
    // MARK: Properties

    private let titleText: LocalizedStringKey
    private let tintColor: Color
    private let intent: PassthroughSubject<TimerVM.Intent, Never>
    
    // MARK: Initializer
    
    init(
        timerState: TimerState,
        tintColor: Color,
        intent: PassthroughSubject<TimerVM.Intent, Never>
    ) {
        self.titleText = timerState == .timeout ?
        "24시간 동안 조작이 없어\n초기화했어요" :
        "타이머를 설정하려면\n가볍게 탭 하세요"
        self.tintColor = tintColor
        self.intent = intent
    }
    
    // MARK: View
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            intent.send(.setupButtonTapped)
            
        } label: {
            VStack(spacing: 15) {
                Image(systemName: "clock.fill").resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(tintColor)
                
                Text(titleText)
                    .font(.localizedFont28)
                    .foregroundStyle(Color.textBlack)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.pageIvory)
                    .stroke(.black.opacity(0.20), lineWidth: 0.5)
            }
        }
    }
}

#Preview {
    TimerEntryView(
        timerState: .timeout,
        tintColor: .palette[0],
        intent: .init()
    )
}
