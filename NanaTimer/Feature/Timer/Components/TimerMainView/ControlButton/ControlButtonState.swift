//
//  ControlButtonState.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI

struct ControlButtonState {
    let iconName: String
    let iconColor: Color
    let text: LocalizedStringKey
    let textColor: Color
    let isDisabled: Bool
        
    init(_ timerState: TimerState, _ tintColor: Color) {
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
    }
}
