//
//  ChartData.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/27/24.
//

import SwiftUI

struct ChartModel {
    @IntArrayStorage("weekdayUpTimes") var weekdayUpTimes: [Int] // [0]부터 일 월 화 수 목...
    @IntStorage("lastWeekday") var lastWeekday: Int
    
    var colorPalette: [Color] = Color.chuColorPalette
    
    var currentWeekday: Int {
        Calendar.current.component(.weekday, from: Date())
    }
    
    init() {
        self.colorPalette.shuffle()
    }
                
    func getDateComponents(date: Date) -> (hour: Int, minute: Int, second: Int, weekday: Int) {
        let date = Calendar.current.dateComponents([.hour, .minute, .second, .weekday], from: date)
        guard let hour = date.hour,
              let minute = date.minute,
              let second = date.second,
              let weekday = date.weekday else { return (hour: 0, minute: 0, second: 0, weekday: 0) }
        return (hour: hour, minute: minute, second: second, weekday: weekday)
    }

}
