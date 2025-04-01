//
//  TimerStateStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//

import Foundation

@propertyWrapper
struct TimerStateStorage {
    var wrappedValue: TimerState {
        get { TimerState(rawValue: UserDefaults.standard.integer(forKey: "state"))! }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: "state") }
    }
}
