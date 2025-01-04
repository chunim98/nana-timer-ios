//
//  TimerMainView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/4/25.
//

import SwiftUI

struct TimerMainView: View {
    @Binding var timerVM: TimerVM
    
    @State var isAlertShowing = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                
                // 설정시간, 타이머, 달성률 표시
                VStack(spacing: .zero) {
                    Text("설정시간: \(timerVM.timerModel.settedTime.cutHour)시간 \(timerVM.timerModel.settedTime.cutMinute)분")
                        .font(.chuCustomFont(size: 18))
                        .foregroundColor(Color.chuText.opacity(0.5))
                        .padding(.bottom)
                    
                    Text(
                        String(
                            format: "%02d : %02d : %02d",
                            timerVM.timerModel.remainingTime.cutHour,
                            timerVM.timerModel.remainingTime.cutMinute,
                            timerVM.timerModel.remainingTime.cutSecond))
                    .font(.chuCustomFont(size: 48))
                    .foregroundColor(timerVM.timerModel.upDays <= 7 ? Color.chuText : Color.chuText.opacity(0.5))
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("\(timerVM.timerModel.achievementRate)%")
                            .font(.chuCustomFont(size: 18))
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(timerVM.timerModel.colorPalette[2])
                            )
                            .foregroundColor(Color.chuBack)
                        
                        Text(timerVM.daysText)
                            .font(.chuCustomFont(size: 18))
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(timerVM.timerModel.colorPalette[3])
                            )
                            .foregroundColor(Color.chuBack)
                    }
                }
                
                
                Spacer()
                
                // 타이머 시작, 정지 등 버튼
                Button {
                    timerVM.tappedFire(); HapticManager.shared.occurLight()
                } label: {
                    VStack {
                        switch timerVM.timerModel.state {
                        case .idle:
                            Image(systemName: "play.fill").resizable().frame(width: 50, height: 50).foregroundStyle(timerVM.timerModel.colorPalette[1])
                        case .run:
                            Image(systemName: "pause.fill").resizable().frame(width: 50, height: 50).foregroundStyle(timerVM.timerModel.colorPalette[1])
                        case .paused:
                            Image(systemName: "playpause.fill").resizable().frame(width: 50, height: 50).foregroundStyle(timerVM.timerModel.colorPalette[1])
                        case .end:
                            Image(systemName: "clock.fill").resizable().frame(width: 50, height: 50).foregroundStyle(Color.chuText.opacity(0.5))
                        default:
                            Image(systemName: "macmini.fill").resizable().frame(width: 50, height: 50).foregroundStyle(Color.chuSubBack)
                        }
                        switch timerVM.timerModel.state {
                        case .idle:
                            Text("시작").foregroundColor(Color.chuText)
                        case .run:
                            Text("일시정지").foregroundColor(Color.chuText)
                        case .paused:
                            Text("재시작").foregroundColor(Color.chuText)
                        case .end:
                            Text("타이머 종료").foregroundColor(Color.chuText.opacity(0.5))
                        default:
                            Text("")
                        }
                    }
                    .font(.chuCustomFont(size: 28))
                }
                .disabled(timerVM.timerModel.state == .end)
                .frame(maxHeight: proxy.size.height * 0.4)
                .buttonStyle(ChuUIButton())
                
                Spacer()
                
                // 타이머 초기화 버튼(확인 얼럿 표시)
                Button {
                    isAlertShowing.toggle()
                    HapticManager.shared.occurLight()
                } label: {
                    Image(systemName: "trash.fill").resizable().frame(width: 25, height: 25).foregroundStyle(timerVM.timerModel.colorPalette[0])
                }
                .frame(maxHeight: proxy.size.height * 0.1)
                .buttonStyle(ChuUIButton())
                .alert(
                    "초기화할까요?\n이 작업은 되돌릴 수 없어요",
                    isPresented: $isAlertShowing,
                    actions: {
                        Button("취소", role: .cancel, action: {})
                        Button("초기화") {
                            HapticManager.shared.occurSuccess()
                            withAnimation{ timerVM.timerModel.isTimerViewShowing.toggle() }
                            completion: { timerVM.reset() }
                        }
                    })
            }
            .transition(.blurReplace)
        }
    }
}

#Preview {
    TimerMainView(timerVM: .constant(.init()))
}
