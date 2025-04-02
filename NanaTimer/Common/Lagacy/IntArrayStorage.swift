//
//  IntArrayStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

@propertyWrapper
struct IntArrayStorage {
    let key: String
    
    var wrappedValue: [Int] {
        get {
            return (UserDefaults.standard.array(forKey: key) as? [Int]) ?? [0, 0, 0, 0, 0, 0, 0]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(_ key: String) {
        self.key = key
    }
}