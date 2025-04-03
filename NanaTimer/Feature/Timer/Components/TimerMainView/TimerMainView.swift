//
//  TimerMainView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/4/25.
//

import SwiftUI
import Combine

struct TimerMainView: View {
    
    // MARK: State
    
    private let colors: [Color]
    private let timerState: TimerState
    private let duration: Int
    private let elapsedTime: Int
    private let remainingTime: Int
    private let elapsedDay: Int
    
    // MARK: Properties
    
    private let parentIntent: PassthroughSubject<TimerVM.Intent, Never>
    
    // MARK: Init
    
    init(
        _ state: TimerVM.State,
        _ intent: PassthroughSubject<TimerVM.Intent, Never>
    ) {
        self.colors = state.colors
        self.timerState = state.timerState
        self.duration = state.duration
        self.elapsedTime = state.elapsedTime
        self.remainingTime = state.remainingTime
        self.elapsedDay = state.elapsedTime
        self.parentIntent = intent
    }
    
    // MARK: View
    
    var body: some View {
        VStack {
            Spacer()
            
            // 설정시간, 현재 잔여시간 표시하는 뷰
            TimeIndicatorView(
                dutaion: duration,
                remainingTime: remainingTime,
                elapsedDay: 1 // temp
            )
            
            // 달성률 표시하는 뷰
            AchievementRateView(
                duration: Float(duration),
                elapsedTime: Float(elapsedTime),
                elapsedDay: 1, // temp
                timerState: timerState,
                tintColor1: colors[0],
                tintColor2: colors[1]
            )
            
            Spacer()
            
            // 타이머 조작 버튼
            ControlButton(
                timerState: timerState,
                tintColor: colors[2]
            ) {
                parentIntent.send(.controlButtonTapped)
            }
            
            Spacer().frame(height: 30)
            
            // 타이머 초기화 버튼 (확인 얼럿 표시)
            ResetButton(tintColor: colors[3]) {
                parentIntent.send(.resetAlertAccepted)
            }
        }
    }
}

#Preview {
    TimerMainView(.init(), .init())
}
