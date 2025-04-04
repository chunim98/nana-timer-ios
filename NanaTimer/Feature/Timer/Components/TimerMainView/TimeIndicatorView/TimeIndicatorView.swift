//
//  TimeIndicatorView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import SwiftUI

struct TimeIndicatorView: View {
    
    // MARK: State

    private let durationHour: Int
    private let durationMinute: Int
    private let remainingHour: Int
    private let remainingMinute: Int
    private let remainingSecond: Int
    private let textColor: Color
    
    // MARK: Init
    
    init(
        dutaion: Int,
        remainingTime: Int,
        elapsedDay: Int
    ) {
        self.durationHour = dutaion.cutHour
        self.durationMinute = dutaion.cutMinute
        self.remainingHour = remainingTime.cutHour
        self.remainingMinute = remainingTime.cutMinute
        self.remainingSecond = remainingTime.cutSecond
        self.textColor = elapsedDay <= 7 ? .textBlack : .textGray
    }
    
    // MARK: View
    
    var body: some View {
        Text("설정시간: \(durationHour)시간 \(durationMinute)분")
            .foregroundStyle(Color.textGray)
            .font(.localizedFont18)

        Text(String(
            format: "%02d : %02d : %02d",
            remainingHour,
            remainingMinute,
            remainingSecond
        ))
        .font(.localizedFont48)
        .foregroundStyle(textColor)
    }
}

#Preview {
    TimeIndicatorView(dutaion: 0, remainingTime: 0, elapsedDay: 0)
}
