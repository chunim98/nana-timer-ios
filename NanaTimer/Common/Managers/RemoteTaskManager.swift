//
//  RemoteTaskManager.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/28/24.
//

import SwiftUI

// 이 싱글톤 객체는 뷰 모델간 알림 전송을 위한 것
// NotificationCenter라는 게 있다는 걸 알기 전에 만듦
final class RemoteTaskManager {
    static var shared = RemoteTaskManager()
    
    var task: [String: () -> Void] = [:]
    
    func excuteTask(key: String) {
        guard let task = task[key] else { return }
        task()
    }
}
