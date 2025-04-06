//
//  PushNotificationManager.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

final class PushNotificationManager {
    
    static let shared = PushNotificationManager()
    private let center = UNUserNotificationCenter.current()
    
    private init() {}
    
    // 권한 요청하기
    func requestAuthorization() {
        center.requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { success, error in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("(권한) 적어도 에러는 안뜸")
            }
        }
    }
    
    // 알림 구성하기
    func requestScheduleNotification(
        title: String.LocalizationValue,
        body: String.LocalizationValue,
        interval: TimeInterval
    ) {
        let content = UNMutableNotificationContent()
        content.title = String(localized: title)
        content.body = String(localized: body)
        content.sound = .default
        content.badge = 1
        // content.subtitle = String(localized: subTitle)
        
        print("알림 간격:", interval)
        
        // 알림 발생 조건 구성
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: interval,
            repeats: true
        )
        
        // 알림 내용과 조건을 한데 모아서 리퀘스트 작성
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        // 내 앱의 알림센터 객체에 추가
        center.add(request)
    }
    
    // 등록된 알림 취소
    func cancelNotification() {
        // 곧 다가올 알림 지우기
        center.removeAllPendingNotificationRequests()
        // 현재 사용자 폰에 떠 있는 알림 지우기
        center.removeAllDeliveredNotifications()
        // 뱃지 제거
        center.setBadgeCount(0)
    }
    
    // 알림 설정이 허가되었는지 확인
    func getNotificationSettings() async -> UNNotificationSettings {
       return await center.notificationSettings()
    }
}
