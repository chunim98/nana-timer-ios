//
//  ChartVM.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/28/24.
//

import SwiftUI

final class ChartVM: ObservableObject {
    
    @Published
    var chartModel = ChartModel()
    var timerModel = TimerModel()
    
    
    init() {
        TimerService.shared.taskPerSecond { [weak self] in self?.taskPerSecond() }
        RemoteTaskManager.shared.task["reset"] = { [weak self] in self?.reset() }
        RemoteTaskManager.shared.task["recalculateWeekdayTimeByTimeover"] = { [weak self] in
            guard let self else { return }
            recalculateWeekdayTime(
                offset: timerModel.remainingTime,
                date: Date() + TimeInterval(timerModel.remainingTime))
        }
        RemoteTaskManager.shared.task["recalculateWeekdayTime"] = { [weak self] in
            guard let self else { return }
            recalculateWeekdayTime(
                offset: timerModel.downTime,
                date: Date())
        }
        RemoteTaskManager.shared.task["storeLastWeekday"] = { [weak self] in self?.storeLastWeekday() }
    }
    
    var subTitleText: LocalizedStringKey {
        timerModel.settedTime == 0 ? " " : "단위 (분)"
    }
    
    var titleText: LocalizedStringKey {
        timerModel.settedTime == 0 ? "안녕하세요!" : "공부 현황"
    }
    
    private func reset() {
        chartModel.weekdayUpTimes = [0, 0, 0, 0, 0, 0, 0]
    }
    
    private func increaseWithWeekdayTime() {
        let weekday = chartModel.currentWeekday
        chartModel.weekdayUpTimes[weekday.minus1] += 1
    }
    
    // 잠수시간 > 남은시간: offset = 남은시간, date = 종료예정시간
    // 잠수시간 < 남은시간: offset = 잠수시간, date = 현재시간
    private func recalculateWeekdayTime(offset: Int, date: Date) {
        let new = chartModel.getDateComponents(date: date)
        
        if chartModel.lastWeekday != new.weekday {
            // 새로운 요일 차트 반영
            chartModel.weekdayUpTimes[new.weekday.minus1] += (new.hour.hToSeond + new.minute.mToSecond + new.second)
            // 지난 요일 차트 반영
            chartModel.weekdayUpTimes[chartModel.lastWeekday.minus1] += (offset - (new.hour.hToSeond + new.minute.mToSecond + new.second))
            
        } else {
            // 딱히 날짜가 바뀐 게 아니면 오차만 보정
            chartModel.weekdayUpTimes[new.weekday.minus1] += offset
        }
    }
    
    private func storeLastWeekday() {
        chartModel.lastWeekday = chartModel.currentWeekday
    }
    
    private func taskPerSecond() {
        increaseWithWeekdayTime()
    }
}
