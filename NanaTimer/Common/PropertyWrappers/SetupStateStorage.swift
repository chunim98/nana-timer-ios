//
//  SetupStateStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import Foundation

@propertyWrapper
struct SetupStateStorage {
    private let key = "SetupState"
    
    var wrappedValue: SetupState {
        get { SetupState(rawValue: UserDefaults.standard.integer(forKey: key))! }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: key) }
    }
}
