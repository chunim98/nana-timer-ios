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
            switch vm.state.setupState {
            case .notConfigured:
                TimerEntryView(vm.intent)
                    .transition(.blurReplace)
                
            case .configuring:
                TimerSetupView(vm.intent)
                    .transition(.blurReplace)
                
            case .configured:
                TimerMainView(vm.state, vm.intent)
                    .transition(.blurReplace)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.default, value: vm.state.setupState)
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
    TimerView(.init())
}
