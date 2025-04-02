//
//  BoolStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//

import Foundation

@propertyWrapper
struct BoolStorage {
    private let key: String
    
    var wrappedValue: Bool {
        get { UserDefaults.standard.bool(forKey: key) }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(
        _ key: String,
        _ defaultValue: Bool = false
    ) {
        self.key = key
        // 기본 값 지정, 키 값이 이미 있는 경우에는 무시됨
        UserDefaults.standard.register(defaults: [key : defaultValue])
    }
}
