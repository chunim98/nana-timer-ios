//
//  ComfirmButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI
import Combine

struct ComfirmButton: View {
        
    private let state: TimerSetupVM.State
    private let action: () -> Void
    
    init(
        _ state: TimerSetupVM.State,
        _ action: @escaping () -> Void
    ) {
        self.state = state
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
            
        } label: {
            Text("결정")
                .font(.localizedFont28)
                .foregroundColor(Color.chuSubBack)
                .padding(EdgeInsets(horizontal: 15, vertical: 10))
                .background {
                    let opacity: Double = state.isConfirmButtonDiabled ? 0.5 : 1.0
                    RoundedRectangle(cornerRadius: 25)
                        .fill(state.tintColor.opacity(opacity))
                }
        }
        .disabled(state.isConfirmButtonDiabled)
        .animation(.default, value: state.isConfirmButtonDiabled)
    }
}

#Preview {
    ComfirmButton(.init(), {})
}
