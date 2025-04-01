//
//  TimerHelper.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI
import Combine

final class TimerHelper {
    private weak var timer: Timer?
    var perform: (() -> Void)?

    func start() {
        timer = .scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            self?.perform?()
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
