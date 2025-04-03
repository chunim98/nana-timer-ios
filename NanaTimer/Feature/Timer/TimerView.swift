//
//  TimerView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/28/24.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject private var vm: TimerVM
    
    init(_ vm: TimerVM) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            switch vm.state.screenState {
            case .entry:
                TimerEntryView(
                    timerState: vm.state.timerState,
                    tintColor: vm.state.colors[0],
                    vm.intent
                )
                .transition(.blurReplace)
                
            case .setup:
                TimerSetupView(vm.intent)
                    .transition(.blurReplace)
                
            case .main:
                TimerMainView(vm.state, vm.intent)
                    .transition(.blurReplace)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.default, value: vm.state.screenState)
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
