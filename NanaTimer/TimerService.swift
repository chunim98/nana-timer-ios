//
//  TimerService.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/27/24.
//

import SwiftUI

final class TimerService {
    static var shared = TimerService() // 싱글톤 객체
    
    private weak var timer: Timer? // 타이머 인스턴스, 약한참조
    private var taskQueue: [() -> Void] = [] // 1초마다 이루어질 작업 큐
    
    private init() {}

    // 작업큐에 추가하고 싶은 작업을 이 메서드를 통해 추가 가능
    func taskPerSecond(closure: @escaping () -> Void) {
        taskQueue.append(closure)
    }
    
    func fire() {
        guard timer == nil else { return }
        timer = .scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.taskQueue.forEach { task in task() }
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
