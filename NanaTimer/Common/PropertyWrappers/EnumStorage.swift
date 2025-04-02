//
//  EnumStorage.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import Foundation

/// 원시값을 가진 열거형을 UserDefaults에 저장하도록 대응한 프로퍼티 래퍼
@propertyWrapper
struct EnumStorage<T: RawRepresentable> {
    private let key: String
    
    var wrappedValue: T {
        get {
            // 초기화 때 기본 값 할당하므로, 강제로 언래핑해도 안전
            let rawValue = UserDefaults.standard.object(forKey: key) as! T.RawValue
            return T.init(rawValue: rawValue)!
        }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: key) }
    }
    
    init(
        _ key: String,
        _ defaultValue: T
    ) {
        self.key = key
        // 기본 값 지정, 키 값이 이미 있는 경우에는 무시됨
        UserDefaults.standard.register(defaults: [key : defaultValue.rawValue])
    }
}
