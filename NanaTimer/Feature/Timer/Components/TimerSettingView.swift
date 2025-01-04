//
//  TimerSettingView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/4/25.
//

import SwiftUI

struct TimerSettingView: View {
    @Binding var timerVM: TimerVM
    
    let hoursPicker = Array(0..<112)
    let minutePicker = Array(stride(from: 0, to: 61, by: 10))
    @State var hourData: Int = 0
    @State var minuteData: Int = 0
    @State var isAlertShowing = false
    
    var body: some View {
        VStack {
            // x 모양 버튼
            HStack {
                Spacer()
                Button {
                    withAnimation{ timerVM.timerModel.isSetViewShowing.toggle() }
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(timerVM.timerModel.colorPalette[2])
                        .padding()
                }
            }
            
            Spacer()
                        
            // 휠 타입 피커뷰 2개를 담고 있는 스택
            HStack {
                // 시간 선택 피커
                VStack {
                    Picker("시간", selection: $hourData) {
                        ForEach(0..<hoursPicker.count, id: \.self) { i in
                            Text(String(hoursPicker[i]))
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("\(hourData)시간")
                        .font(.chuCustomFont(size: 24))
                        .foregroundColor(Color.chuText)
                }
                
                // 분 선택 피커
                VStack {
                    Picker("분", selection: $minuteData) {
                        ForEach(0..<minutePicker.count, id: \.self) { i in
                            Text(String(minutePicker[i]))
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("\(minutePicker[minuteData])분")
                        .font(.chuCustomFont(size: 24))
                        .foregroundColor(Color.chuText)
                }
            }
            
            Spacer()
            
            // 결정 버튼
            Button {
                if timerVM.timerModel.state == .idle && hourData == 0 && minuteData == 0 {
                    HapticManager.shared.occurLight()
                    withAnimation{ timerVM.timerModel.isSetViewShowing.toggle() }
                } else {
                    withAnimation {
                        HapticManager.shared.occurLight()
                        timerVM.timerModel.isSetViewShowing.toggle()
                    } completion: {
                        withAnimation { timerVM.timerModel.isTimerViewShowing.toggle()
                        } completion: {
                            HapticManager.shared.occurSuccess()
                            timerVM.timerModel.updateSettedTime(to: hourData.hToSeond + minutePicker[minuteData].mToSecond)
                        }
                    }
                }
            } label: {
                Text("결정")
                    .font(.chuCustomFont(size: 28))
                    .foregroundColor(Color.chuSubBack)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(timerVM.timerModel.colorPalette[2])
                    )
            }
            
            Spacer()
            
            // 사용 안내 텍스트
            Text("Tip. 7일 동안 공부할 시간을 설정하면 돼요")
                .font(.chuCustomFont(size: 16))
                .foregroundColor(Color.chuText.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }
        .transition(.blurReplace)
    }
}

#Preview {
    TimerSettingView(timerVM: .constant(.init()))
}
