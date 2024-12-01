//
//  NanaTimerApp.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 5/30/24.
//

import SwiftUI

@main
struct NanaTimerApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView(mainVM: MainVM(), timerVM: TimerVM(), chartVM:  ChartVM())
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            // 씬 페이즈 상태에 따라 클로저에 상태만 넘겨주는 메서드, 내부 구현은 뷰 모델 재량
            SceneManager.shared.distributeScenePhase(scene: newValue)
            print(scenePhase)
        }
    }
}
