//
//  SetupStateStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import Foundation

@propertyWrapper
struct SetupStateStorage {
    var wrappedValue: SetupState {
        get { SetupState(rawValue: UserDefaults.standard.integer(forKey: "state"))! }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: "state") }
    }
}
