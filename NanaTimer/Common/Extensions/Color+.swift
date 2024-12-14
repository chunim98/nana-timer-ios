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