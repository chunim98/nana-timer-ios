//
//  TimerView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/28/24.
//

import SwiftUI

struct TimerView: View {
    
    // MARK: Properties
    
    @ObservedObject private var vm: TimerVM
    
    // MARK: Initializer
    
    init(vm: TimerVM) {
        self.vm = vm
    }
    
    // MARK: View
    
    var body: some View {
        VStack {
            switch vm.state.screenState {
            case .entry:
                TimerEntryView(
                    timerState: vm.state.timerState,
                    tintColor: vm.state.colors[1],
                    intent: vm.intent
                )
                .transition(.blurReplace)
                
            case .setup:
                TimerSetupView(
                    intent: vm.intent
                )
                .transition(.blurReplace)
                
            case .main:
                TimerMainView(
                    state: vm.state,
                    intent: vm.intent
                )
                .transition(.blurReplace)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // .onAppear() {
        //     // 24시간 동안 조작하지 않으면 초기화하는 코드 예약
        //     RemoteTaskManager.shared.task["timeoutReset"] = {
        //         withAnimation {
        //             timerVM.timerModel.isTimerViewShowing.toggle()
        //         } completion: {
        //             timerVM.reset()
        //         }
        //     }
        // }
    }
}

#Preview {
    HomeView()
}
