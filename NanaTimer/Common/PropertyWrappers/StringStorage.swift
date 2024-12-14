//
//  StringStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

@propertyWrapper
struct StringStorage {
    let key: String
    
    var wrappedValue: String {
        get {
            return UserDefaults.standard.string(forKey: key) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(_ key: String) {
        self.key = key
    }
}