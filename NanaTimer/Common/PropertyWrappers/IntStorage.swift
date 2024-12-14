//
//  IntStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

@propertyWrapper
struct IntStorage {
    let key: String
    let defaultValue: Int
    
    var wrappedValue: Int {
        get {
            UserDefaults.standard.register(defaults: [key : defaultValue])
            return UserDefaults.standard.integer(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(_ key: String, _ defaultValue: Int = 0) {
        self.key = key
        self.defaultValue = defaultValue
    }
}