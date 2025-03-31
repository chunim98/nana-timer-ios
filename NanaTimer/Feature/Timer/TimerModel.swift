//
//  TimerModel.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/27/24.
//

import SwiftUI

struct TimerModel {
    // 타이머 상태 열거형
    enum State: String {
        case idle
        case run
        case paused
        case timerBackground
        case end
        
        var titleText: LocalizedStringKey {
            switch self {
            case .idle:
                "안녕하세요!"
            case .run:
                "힘내세요!"
            case .paused:
                "쉬었다 갈게요!"
            case .end:
                "끝! 고생 많았어요."
            default:
                ""
            }
        }
    }
    
    // MARK: - TimerModel 프로퍼티, 메서드
    @StateStorage private(set) var state: TimerModel.State // 초기값 .idle
    @IntStorage("upTime") var upTime: Int // 초기값 0
    @IntStorage("settedTime") private(set) var settedTime: Int // 초기값 0
    @StringStorage("lastDate") var lastDate: String // 초기값 ""
    @StringStorage("startDay") var startDay: String
    @BoolStorage("isTimerViewShowing") var isTimerViewShowing // 초기값 false
    
    var isSetViewShowing = false
    var colorPalette: [Color] = Color.chuColorPalette
    var infoText: LocalizedStringKey = "타이머를 설정하려면\n가볍게 탭 하세요"
    
    init() { self.colorPalette.shuffle() }

    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd:HH:mm:ss"
        return formatter
    }()
    
    private var daysFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd"
        return formatter
    }()
    
    mutating func updateState(to: TimerModel.State) {
        state = to
    }
    
    mutating func updateSettedTime(to: Int) {
        settedTime = to
    }
        
    var remainingTime: Int {
        settedTime - upTime
    }
    
    var downTime: Int {
        guard let oldDate = formatter.date(from: lastDate) else { return 0 }
        let newDate = Date()
        return Int(oldDate.distance(to: newDate)) // 현재부터 storedDate까지의 거리
    }
    
    var achievementRate: Int {
        guard settedTime != 0 else { return 0 }
        let upTime = Float(upTime)
        let settedTime = Float(settedTime)
        return Int(upTime / settedTime * 100)
    }
    
    var currentDate: String {
        formatter.string(from: Date())
    }
    
    var currentDay: String {
        daysFormatter.string(from: Date())
    }
    
    var upDays: Int {
        guard let oldDate = daysFormatter.date(from: startDay) else { return 1 }
        guard let newDate = daysFormatter.date(from: currentDay) else { return 1 }
        return (Int(oldDate.distance(to: newDate)) / 86400) + 1
    }
}
