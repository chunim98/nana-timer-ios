//
//  TimeIndicatorView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import SwiftUI

struct TimeIndicatorView: View {
    
    // MARK: State
    
    private let hourComponent: Int
    private let minuteComponent: Int
    private let secondComponent: Int
    private let textColor: Color
    
    // MARK: Init
    
    init(
        remainingTime: Int,
        elapsedDay: Int
    ) {
        self.hourComponent = remainingTime.cutHour
        self.minuteComponent = remainingTime.cutMinute
        self.secondComponent = remainingTime.cutSecond
        self.textColor = elapsedDay <= 7 ? .chuText : .chuText.opacity(0.5)
    }
    
    // MARK: View
    
    var body: some View {
        Text("설정시간: \(hourComponent)시간 \(minuteComponent)분")
            .foregroundColor(Color.chuText.opacity(0.5))
            .font(.localizedFont18)

        Text(String(
            format: "%02d : %02d : %02d",
            hourComponent,
            minuteComponent,
            secondComponent
        ))
        .font(.localizedFont48)
        .foregroundColor(textColor)
    }
}

#Preview {
    TimeIndicatorView(remainingTime: 0, elapsedDay: 0)
}
