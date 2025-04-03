//
//  Calendar+.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/3/25.
//

import Foundation

extension Calendar {
    
    struct SmallComponent {
        let hour: Int
        let minute: Int
        let second: Int
        let weekday: Int
        
        /// 시간, 분, 초를 합산하여 총 초(second) 단위로 변환
        var totalSeconds: Int {
            (hour*3600) + (minute*60) + second
        }
    }
    
    func getSmallComponent(_ date: Date) -> SmallComponent {
        SmallComponent(
            hour: self.component(.hour, from: date),
            minute: self.component(.minute, from: date),
            second: self.component(.second, from: date),
            weekday: self.component(.weekday, from: date)
        )
    }
}
