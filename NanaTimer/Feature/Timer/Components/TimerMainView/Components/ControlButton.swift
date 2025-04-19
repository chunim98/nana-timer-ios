//
//  ControlButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI

struct ControlButton: View {
    
    // MARK: Properties
    
    private let iconName: String
    private let iconColor: Color
    private let text: LocalizedStringKey
    private let textColor: Color
    private let isDisabled: Bool
    private let perform: () -> Void
    
    // MARK: Initializer
    
    init(
        timerState: TimerState,
        tintColor: Color,
        perform: @escaping () -> Void
    ) {
        switch timerState {
        case .ready:
            self.iconName = "play.fill"
            self.iconColor = tintColor
            self.text = "시작"
            self.textColor = .textBlack
            self.isDisabled = false
            
        case .running:
            self.iconName = "pause.fill"
            self.iconColor = tintColor
            self.text = "일시정지"
            self.textColor = .textBlack
            self.isDisabled = false
            
        case .paused:
            self.iconName = "playpause.fill"
            self.iconColor = tintColor
            self.text = "재시작"
            self.textColor = .textBlack
            self.isDisabled = false
            
        case .finished:
            self.iconName = "clock.fill"
            self.iconColor = .textGray
            self.text = "타이머 종료"
            self.textColor = .textGray
            self.isDisabled = true
            
        default:
            self.iconName = ""
            self.iconColor = tintColor
            self.text = ""
            self.textColor = .textBlack
            self.isDisabled = false
        }
        
        self.perform = perform
    }
    
    // MARK: View
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            perform()
            
        } label: {
            VStack {
                Image(systemName: iconName).resizable()
                    .foregroundStyle(iconColor)
                    .frame(width: 50, height: 50)
                
                Text(text)
                    .foregroundStyle(textColor)
                    .font(.localizedFont28)
            }
        }
        .disabled(isDisabled)
        .buttonStyle(PressPopButtonStyle())
        .frame(height: 300)
    }
}

#Preview {
    ControlButton(
        timerState: .finished,
        tintColor: .backgroundBeige,
        perform: {}
    )
}
