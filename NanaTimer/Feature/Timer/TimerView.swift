//
//  TimerView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/28/24.
//

import SwiftUI

struct TimerView: View {
    @State var timerVM: TimerVM
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if !timerVM.timerModel.isTimerViewShowing {
                    VStack {
                        if !timerVM.timerModel.isSetViewShowing {
                            // TimerEntryView
                            TimerEntryView(timerVM: $timerVM)
                        } else {
                            // TimerSettingView
                            TimerSettingView(timerVM: $timerVM)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .modifier(ChuUIModifier())
                    
                } else {
                    // MARK: - Timer View
                    TimerMainView(timerVM: $timerVM)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.bouncy, value: timerVM.timerModel.upTime)
            .onAppear() {
                // 24시간 동안 조작하지 않으면 초기화하는 코드 예약
                RemoteTaskManager.shared.task["timeoutReset"] = {
                    withAnimation {
                        timerVM.timerModel.isTimerViewShowing.toggle()
                    } completion: {
                        timerVM.reset()
                    }
                }
            }
        }
    }
}

#Preview {
    TimerView(timerVM: TimerVM())
}
