//
//  ControlButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI

struct ControlButton: View {
    
    // MARK: State
    
    private let state: ControlButtonState
    
    // MARK: Properties
    
    private let action: () -> Void
    
    // MARK: Init
    
    init(
        timerState: TimerState,
        tintColor: Color,
        action: @escaping () -> Void
    ) {
        self.state = ControlButtonState(timerState, tintColor)
        self.action = action
    }
    
    // MARK: View
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            action()
            
        } label: {
            VStack {
                Image(systemName: state.iconName).resizable()
                    .foregroundStyle(state.iconColor)
                    .frame(width: 50, height: 50)
                
                Text(state.text)
                    .foregroundStyle(state.textColor)
                    .font(.localizedFont28)
            }
        }
        .disabled(state.isDisabled)
        .buttonStyle(ChuUIButton())
        .frame(height: 300)
    }
}

#Preview {
    ControlButton(
        timerState: .finished,
        tintColor: .backgroundBeige,
        action: {}
    )
}
