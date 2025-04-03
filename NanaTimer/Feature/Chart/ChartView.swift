//
//  ChartView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/23/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @StateObject var chartVM: LegacyChartVM = .init()
    
    var body: some View {
        ZStack {
            Chart {
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[1].sToMinute),
                    y: .value(" ", String(localized: "월"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[0])
                .cornerRadius(10, style: .continuous)
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[2].sToMinute),
                    y: .value(" ", String(localized: "화"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[1])
                
                .cornerRadius(10, style: .continuous)
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[3].sToMinute),
                    y: .value(" ", String(localized: "수"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[2])
                .cornerRadius(10, style: .continuous)
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[4].sToMinute),
                    y: .value(" ", String(localized: "목"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[3])
                .cornerRadius(10, style: .continuous)
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[5].sToMinute),
                    y: .value(" ", String(localized: "금"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[4])
                .cornerRadius(10, style: .continuous)
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[6].sToMinute),
                    y: .value(" ", String(localized: "토"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[5])
                .cornerRadius(10, style: .continuous)
                BarMark(
                    x: .value(" ", chartVM.chartModel.weekdayUpTimes[0].sToMinute),
                    y: .value(" ", String(localized: "일"))
                )
                .foregroundStyle(chartVM.chartModel.colorPalette[6])
                .cornerRadius(10, style: .continuous)
            }
            .padding()
            .chartYAxis { // 차트 그리드 숨기기
                AxisMarks(position: .automatic) { _ in
                    AxisValueLabel() // 값 라벨 관리
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(ChuUIModifier())
            .animation(.bouncy, value: chartVM.timerModel.upTime)
            
            
            if chartVM.timerModel.settedTime == 0 {
                VStack {
                    Image(systemName: "questionmark.folder.fill")
                        .resizable()
                        .frame(width: 123, height: 100)
                        .foregroundStyle(chartVM.chartModel.colorPalette[0])
                        .padding()
                    Text("아직 공부 현황이 없는 것 같아요")
                        .font(.chuCustomFont(size: 18))
                        .foregroundColor(Color.chuText.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .modifier(ChuUIModifier())
            }
        }
    }
}



#Preview {
    ChartView(chartVM: LegacyChartVM())
}
