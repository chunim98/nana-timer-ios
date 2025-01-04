//
//  TimerVM.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/27/24.
//

import SwiftUI

@Observable
final class TimerVM {
    
    var timerModel = TimerModel()
    @ObservationIgnored var setModel = SettingsModel()


    
    init() {
        TimerService.shared.taskPerSecond { [weak self] in self?.taskPerSecond() }
        SceneManager.shared.taskSceneUpdate { [weak self] scene in self?.taskSceneUpdate(scene: scene) }
    }
    
    var statusText: LocalizedStringKey {
        switch timerModel.state{
        case .idle:
            return timerModel.settedTime == 0 ? "안녕하세요!" : "준비됐나요?"
        case .run:
            return "힘내세요!"
        case .paused:
            return "쉬었다 갈게요!"
        case .timerBackground:
            return ""
        case .end:
            return "끝! 고생 많았어요."
        }
    }
    
    var daysText: LocalizedStringKey{
        if timerModel.state == .end && timerModel.upDays <= 7{
            return "성공(\(timerModel.upDays)일차)"
        }else if timerModel.upDays == 7{
            return "마지막 날(\(timerModel.upDays)일차)"
        }else if timerModel.upDays > 7{
            return "실패(\(timerModel.upDays)일차)"
        }
        return "\(timerModel.upDays)일차"
    }
    
    func tappedFire() {
        switch timerModel.state {
        case .idle:
            start()
            timerModel.startDay = timerModel.currentDay // 최초로 타이머를 시작했을 때 시작날짜 저장
        case .run:
            pause()
        case .paused:
            start()
        default:
            break
        }
    }
    
    func start() {
        TimerService.shared.fire()
        timerModel.updateState(to: .run)
    }
    
    func pause() {
        TimerService.shared.invalidate()
        timerModel.updateState(to: .paused)
    }
    
    func reset() {
        TimerService.shared.invalidate()
        timerModel.updateState(to: .idle)
        timerModel.upTime = 0
        timerModel.updateSettedTime(to: 0)
        timerModel.lastDate = ""
        timerModel.startDay = ""
        
        // 차트VM에게 초기화 해야함을 알림
        // 차트VM에 대한 의존성은 없으니 mvvm맞음, 아무튼 맞음
        RemoteTaskManager.shared.excuteTask(key: "reset")
    }
    
    private func end() {
        TimerService.shared.invalidate()
        timerModel.updateState(to: .end)
        timerModel.upTime = timerModel.settedTime
    }
    
    private func background() {
        TimerService.shared.invalidate()
        timerModel.updateState(to: .timerBackground)
    }
    
    private func taskPerSecond() {
        timerModel.upTime += 1
        if timerModel.remainingTime == 0 { end() }
        if setModel.isOnTactile { HapticManager.shared.occurRigid() }
        
        print(timerModel.upTime, timerModel.state)
        print("남은시간", timerModel.remainingTime)
    }
    
    private func taskSceneUpdate(scene: ScenePhase) {
        let downTime = timerModel.downTime

        switch scene {
        case .active:
            guard timerModel.state == .timerBackground else { return }
            guard downTime < 86400 else {
                timerModel.infoText =  "24시간 동안 조작이 없어\n초기화했어요"
                RemoteTaskManager.shared.excuteTask(key: "timeoutReset") // 애니메이션 때문에 타이머뷰에 연결돼있음 reset()
                return
            }
            guard downTime < timerModel.remainingTime else {
                RemoteTaskManager.shared.excuteTask(key: "recalculateWeekdayTimeByTimeover")

                end()
                print("얼마나 오래있다 온거야..")
                // 차트 오차범위만큼 재계산하라고 알림
                return
            }
            
            start()
            timerModel.upTime += downTime
            print("다운타임: \(downTime)")
            print("업타임: \(timerModel.upTime)")
            
            // 차트 오차범위만큼 재계산하라고 알림
            RemoteTaskManager.shared.excuteTask(key: "recalculateWeekdayTime")
            
        case .background:
            guard timerModel.state == .run else { return }
            timerModel.lastDate = timerModel.currentDate
            background()
                        
            // 마지막 요일 저장하라고 알림
            RemoteTaskManager.shared.excuteTask(key: "storeLastWeekday")
            
        default: // .inactive는 의도적으로 미구현
            return
        }
    }
}
