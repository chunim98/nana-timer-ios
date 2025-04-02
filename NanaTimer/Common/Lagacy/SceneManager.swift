//
//  SceneManager.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/27/24.
//

import SwiftUI

final class SceneManager {
    static var shared = SceneManager()
    
    private var taskQueue: [(ScenePhase) -> Void] = [] // 작업 큐
    
    private init() {}

    // 작업큐에 추가하고 싶은 작업을 이 메서드를 통해 추가 가능
    func taskSceneUpdate(closure: @escaping (ScenePhase) -> Void) {
        taskQueue.append(closure)
    }
    
    // 신페이즈 케이스 전달해서 클로저 실행
    func distributeScenePhase(scene: ScenePhase) {
        taskQueue.forEach { task in task(scene) }
    }
}
