//
//  TimerEntryView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/3/25.
//

import SwiftUI

struct TimerEntryView: View {
    @Binding var timerVM: TimerVM
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            withAnimation{ timerVM.timerModel.isSetViewShowing.toggle() }
        } label: {
            VStack {
                Image(systemName: "clock.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(timerVM.timerModel.colorPalette[1])
                    .padding()
                Text(timerVM.timerModel.infoText)
                    .font(.chuCustomFont(size: 28))
                    .foregroundColor(Color.chuText)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    TimerEntryView(timerVM: .constant(TimerVM()))
}
