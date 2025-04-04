//
//  ChartData.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/3/25.
//

import SwiftUI

struct ChartData: Identifiable, Equatable {
    let weakdayText: String
    let dailyStudied: Int
    let barColor: Color
    
    // id가 weakdayText인 이유:
    // id가 변경되면 차트는 완전히 새로 그려지며 애니메이션이 정상 동장하지 않음(깜박거림).
    // 때문에 불변하지 않는 weakdayText를 사용해서 애니메이션의 정상 동작을 보장함.
    var id: String { weakdayText }
}
