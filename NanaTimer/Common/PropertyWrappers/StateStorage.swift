//
//  StateStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

@propertyWrapper
struct StateStorage {
    var wrappedValue: TimerModel.State {
        get {
            let stateRaw = UserDefaults.standard.string(forKey: "STATE") ?? TimerModel.State.idle.rawValue
            return TimerModel.State(rawValue: stateRaw)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "STATE")
        }
    }
}