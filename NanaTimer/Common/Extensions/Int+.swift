//
//  Int+.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//

import SwiftUI

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
