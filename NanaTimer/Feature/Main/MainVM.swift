//
//  MainVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/12/24.
//

import SwiftUI

final class MainVM: ObservableObject {
    
    var timerModel = TimerModel()
    var setModel = SetModel()
    
    init() {
        SceneManager.shared.taskSceneUpdate { [weak self] scene in self?.notifySceneUpdate(scene: scene) }
    }
    
    
    
    // 네비게이션 뷰 색 바꿔주는 코드, 스크롤 시에도 색이 변하지 않음
    func configureNavigationViewStyle() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationBarAppearance.backgroundColor = UIColor(Color.chuBack)// 이게 되네..
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func notifySceneUpdate(scene: ScenePhase) {
        switch scene {
        case .active:
            guard timerModel.state == .timerBackground else { return }
            PushNotificationManager.shared.cancelNotification()
            
        case .background:
            guard timerModel.state == .run else { return }
            guard setModel.isOnNotify else { return }
            PushNotificationManager.shared.requestScheduleNotification(title: "나나타이머", body: "타이머가 실행중이에요.", interval: Double(setModel.notiInterval.mToSecond))
            
        default:// .inactive는 의도적으로 미구현
            return
        }
    }
}
