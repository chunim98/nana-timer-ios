//
//  UtilityExtension.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/26/24.
//

import SwiftUI

// MARK: - extension
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static var chuBack: Self {
        Color.init(hex: 0xe8e2e2)
    }
    
    static var chuSubBack: Self {
        Color.init(hex: 0xfaf6f3)
    }
    
    static var chuSubBackShade: Self {
        Color.init(hex: 0xcdc7c7)
    }
    
    static var chuText: Self {
        Color.init(hex: 0x464044)
    }
    
    static var chuColorPalette: [Self] {
        let array: [Color] = [
            .init(hex: 0x4e4a5b),
            .init(hex: 0x8b8591),
            .init(hex: 0xaeb8c0),
            .init(hex: 0x595072),
            .init(hex: 0xc3b6bf),
            .init(hex: 0xc5b1b1),
            .init(hex: 0xc6bcb9),
            .init(hex: 0x937c83),
            .init(hex: 0xdba37d),
            .init(hex: 0xc1826e),
            .init(hex: 0x7d7688),
            .init(hex: 0x725e6c)]
        return array
    }
}

extension Int {
    // Self == Int, self는 인스턴스
    var cutHour: Self { self / 3600 }
    var cutMinute: Self { (self % 3600) / 60 }
    var cutSecond: Self { (self % 3600) % 60 }
    var hToSeond: Self { self * 3600 }
    var mToSecond: Self { self * 60 }
    var sToMinute: Self { self / 60 }
    var minus1: Self { self - 1 }
}

extension Font {
    static func chuCustomFont(size: Float) -> Font {
        guard let languageCode = Locale.current.language.languageCode?.identifier else {
            return .system(size: CGFloat(size))
        }
        
        switch languageCode {
        case "ja":
            return Font.custom("rounded-mplus-1c-medium", size: CGFloat(size - 2))
        default:
            return Font.custom("NanumSquareRoundOTFB", size: CGFloat(size))
        }
    }
}

// MARK: - @propertyWrapper
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

@propertyWrapper
struct BoolStorage {
    let key: String
    let defaultValue: Bool
    
    var wrappedValue: Bool {
        get {
            UserDefaults.standard.register(defaults: [key : defaultValue])
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(_ key: String, _ defaultValue: Bool = false) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

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


// MARK: - Custom View
struct ChuUIButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.chuSubBackShade)
                        .stroke(Color.chuSubBackShade, lineWidth: 0.5)
                        .offset(y: configuration.isPressed ? 0 : 5)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.chuSubBack)
                        .stroke(Color.chuSubBackShade, lineWidth: 0.5)
                })
            .offset(y: configuration.isPressed ? 5 : 0)
            .offset(y: -5)
    }
}

struct ChuUIModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.chuSubBack)
                        .stroke(Color.chuSubBackShade, lineWidth: 0.5)
                })
    }
}

