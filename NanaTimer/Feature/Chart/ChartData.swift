//
//  ChartData.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/3/25.
//

import SwiftUI

struct ChartData: Identifiable, Equatable {
        let id = UUID().uuidString
        let weakdayText: String
        let dailyStudied: Int
        let barColor: Color
    }
