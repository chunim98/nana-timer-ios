//
//  Font+.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//

import SwiftUI

extension Font {
    static func getLocalizedFont(size: CGFloat) -> Font {
        let languageCode = Locale.current.language.languageCode?.identifier ?? ""
        
        return languageCode == "ja" ?
        Font.custom("rounded-mplus-1c-medium", size: size-2) :
        Font.custom("NanumSquareRoundOTFB", size: size)
    }
    
    static let localizedFont14 = getLocalizedFont(size: 14)
    static let localizedFont16 = getLocalizedFont(size: 16)
    static let localizedFont18 = getLocalizedFont(size: 18)
    static let localizedFont24 = getLocalizedFont(size: 24)
    static let localizedFont28 = getLocalizedFont(size: 28)
    static let localizedFont36 = getLocalizedFont(size: 36)
    static let localizedFont48 = getLocalizedFont(size: 48)
}
