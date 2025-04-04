//
//  Color+.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//

import SwiftUI

extension Color {
    
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static let backgroundBeige = Color(hex: 0xe8e2e2)
    static let pageDarkIvory = Color(hex: 0xcdc7c7)
    static let pageIvory = Color(hex: 0xfaf6f3)
    static let textBlack = Color(hex: 0x464044)
    static let textGray = Color(hex: 0x464044, opacity: 0.5)
    static let palette = [
        Color(hex: 0x4e4a5b), Color(hex: 0x8b8591),
        Color(hex: 0xaeb8c0), Color(hex: 0x595072),
        Color(hex: 0xc3b6bf), Color(hex: 0xc5b1b1),
        Color(hex: 0xc6bcb9), Color(hex: 0x937c83),
        Color(hex: 0xdba37d), Color(hex: 0xc1826e),
        Color(hex: 0x7d7688), Color(hex: 0x725e6c)
    ]
}
