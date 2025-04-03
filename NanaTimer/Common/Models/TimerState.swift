//
//  TimerState.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUICore

enum TimerState: Int, CaseIterable {
    /// 타이머가 초기화 되지 않은 상태
    case idle
    /// 타이머가 초기화되었지만 시작되지 않은 상태
    case ready
    /// 타이머가 실행 중인 상태
    case running
    /// 타이머가 일시 정지된 상태
    case paused
    /// 타이머가 백그라운드로 전환된 상태
    case backgrounded
    /// 타이머가 종료된 상태
    case finished
    /// 타이머가 24시간 동안 방치되어 초기화 된 상태
    case timeout
}
