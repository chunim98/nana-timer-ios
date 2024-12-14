//
//  Font+.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

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