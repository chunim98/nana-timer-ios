//
//  Int+.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//

import SwiftUI

extension Int {
    /// 전체에서 시간 단위만 추출
    var hourCmp: Int { self / 3600 }
    /// 전체에서 시간을 추출하고 남은 분 단위만 추출
    var minCmp: Int { (self % 3600) / 60 }
    /// 전체에서 시간과 분을 추출하고 남은 초 단위만 추출
    var secCmp: Int { (self % 3600) % 60 }
    /// 시간을 초로 변환
    var hourToSec: Int { self * 3600 }
    /// 분을 초로 변환
    var minToSec: Int { self * 60 }
    
    var weekdayText: String.LocalizationValue {
        switch self {
        case 1: "일"
        case 2: "월"
        case 3: "화"
        case 4: "수"
        case 5: "목"
        case 6: "금"
        case 7: "토"
        default: ""
        }
    }
}
