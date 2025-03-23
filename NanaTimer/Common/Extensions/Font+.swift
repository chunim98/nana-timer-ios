//
//  Font+.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

extension Font {
    static func chuCustomFont(size: Float) -> Font {
        let languageCode = Locale.current.language.languageCode?.identifier ?? ""
        
        switch languageCode {
        case "ja":
            return Font.custom("rounded-mplus-1c-medium", size: CGFloat(size - 2))
        default:
            return Font.custom("NanumSquareRoundOTFB", size: CGFloat(size))
        }
    }
    
    static let localizedFont14 = chuCustomFont(size: 14)
    static let localizedFont16 = chuCustomFont(size: 16)
    static let localizedFont18 = chuCustomFont(size: 18)
    static let localizedFont24 = chuCustomFont(size: 24)
    static let localizedFont28 = chuCustomFont(size: 28)
    static let localizedFont36 = chuCustomFont(size: 36)
    static let localizedFont48 = chuCustomFont(size: 48)
}
