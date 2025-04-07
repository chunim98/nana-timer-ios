//
//  ChartView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/23/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    // MARK: Properties
    
    private let screenState: TimerScreenState
    private let dataArr: [ChartData]
    private let tintColors: [Color]
    
    // MARK: Initializer
    
    init(
        screenState: TimerScreenState,
        dailyStudyTimes: [Int],
        tintColors: [Color]
    ) {
        self.screenState = screenState
        self.tintColors = tintColors
        
        self.dataArr = Array(1...7).map { i in ChartData(
            weakdayText: String(localized: i.weekdayText),
            dailyStudied: dailyStudyTimes[i],
            barColor: tintColors[i]
        ) }
    }
    
    // MARK: View
    
    var body: some View {
        VStack {
            if screenState == .main {
                Chart(dataArr) {
                    BarMark(
                        x: .value("dailyStudied", $0.dailyStudied),
                        y: .value("weakdayText", $0.weakdayText)
                    )
                    .cornerRadius(10, style: .continuous)
                    .foregroundStyle($0.barColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(.bouncy, value: dataArr)
                
            } else {
                ChartEmptyView(tintColor: tintColors[0])
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.pageIvory)
                .stroke(Color.pageDarkIvory, lineWidth: 0.5)
        }
    }
}

#Preview {
    ChartView(
        screenState: .main,
        dailyStudyTimes: (0...8).map { _ in Int.random(in: 10...50) },
        tintColors: Color.palette.shuffled()
    )
}
