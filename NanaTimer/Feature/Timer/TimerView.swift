//
//  TimerView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 6/28/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timerVM: TimerVM
    
    let hoursPicker = Array(0..<112)
    let minutePicker = Array(stride(from: 0, to: 61, by: 10))
    @State var hourData: Int = 0
    @State var minuteData: Int = 0
    @State var isAlertShowing = false
    
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if !timerVM.timerModel.isTimerViewShowing {
                    VStack{
                        if !timerVM.timerModel.isSetViewShowing {
                            //MARK: -  MainView
                            Button(action: {
                                HapticManager.shared.occurLight()
                                withAnimation{ timerVM.timerModel.isSetViewShowing.toggle() }
                            }, label: {
                                VStack {
                                    Image(systemName: "clock.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(timerVM.timerModel.colorPalette[1])
                                        .padding()
                                    Text(timerVM.timerModel.infoText)
                                        .font(.chuCustomFont(size: 28))
                                        .foregroundColor(Color.chuText)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            })
                        }else{
                            //MARK: -  SetView
                            Button(action: { withAnimation{ timerVM.timerModel.isSetViewShowing.toggle() } }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .trailing)
                                    .foregroundStyle(timerVM.timerModel.colorPalette[2])
                            })
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .topTrailing)
                            Spacer(minLength: geo.size.height * 0.1)
                            VStack {
                                HStack {
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
                                    .frame(maxWidth: geo.size.width * 0.35)
                                    .padding()
                                    
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
                                    .frame(maxWidth: geo.size.width * 0.35)
                                    .padding()
                                    
                                }
                                Button(
                                    action: {
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
//                                                    timerVM.timerModel.updateSettedTime(to: 10)
                                                }
                                            }
                                        }
                                    },
                                    label: {
                                        Text("결정")
                                            .font(.chuCustomFont(size: 28))
                                            .foregroundColor(Color.chuSubBack)
                                    })
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(RoundedRectangle(cornerRadius: 25).fill(timerVM.timerModel.colorPalette[2]))
                                
                                Spacer()
                                Text("Tip. 7일 동안 공부할 시간을 설정하면 돼요")
                                    .font(.chuCustomFont(size: 16))
                                    .foregroundColor(Color.chuText.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                            }
                            .transition(.blurReplace)
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .modifier(ChuUIModifier())
                    
                }else{
                    //MARK: -  Timer View
                    VStack{
                        VStack {
                            Text("설정시간: \(timerVM.timerModel.settedTime.cutHour)시간 \(timerVM.timerModel.settedTime.cutMinute)분")
                                .font(.chuCustomFont(size: 18))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.chuText.opacity(0.5))
                                .padding(.bottom, 1)// v스택에 기본적인 스페이싱이 들어가 있어서 1만 줘도 되는 거 같다
                            
                            Text(String(format: "%02d : %02d : %02d", timerVM.timerModel.remainingTime.cutHour, timerVM.timerModel.remainingTime.cutMinute, timerVM.timerModel.remainingTime.cutSecond))
                                .font(.chuCustomFont(size: 48))
                                .foregroundColor(timerVM.timerModel.upDays <= 7 ? Color.chuText : Color.chuText.opacity(0.5))
                            
                            HStack {
                                Text("\(timerVM.timerModel.achievementRate)%")
                                    .font(.chuCustomFont(size: 18))
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(timerVM.timerModel.colorPalette[2]))
                                    .foregroundColor(Color.chuBack)
                                Text(timerVM.daysText)
                                    .font(.chuCustomFont(size: 18))
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(timerVM.timerModel.colorPalette[3]))
                                    .foregroundColor(Color.chuBack)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                        Spacer(minLength: geo.size.height * 0.05)
                        
                        Button(action: { timerVM.tappedFire(); HapticManager.shared.occurLight() }, label: {
                            VStack{
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
                        })
                        .disabled(timerVM.timerModel.state == .end)
                        .frame(maxHeight: geo.size.height * 0.5)
                        .buttonStyle(ChuUIButton())
                        
                        Spacer(minLength: geo.size.height * 0.05)
                        
                        Button(action: { isAlertShowing.toggle(); HapticManager.shared.occurLight() }, label: {
                            Image(systemName: "trash.fill").resizable().frame(width: 25, height: 25).foregroundStyle(timerVM.timerModel.colorPalette[0])
                        })
                        .frame(maxHeight: geo.size.height * 0.1)
                        .buttonStyle(ChuUIButton())
                        .alert("초기화할까요?\n이 작업은 되돌릴 수 없어요", isPresented: $isAlertShowing, actions: {
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.bouncy, value: timerVM.timerModel.upTime)
            .onAppear() {
                RemoteTaskManager.shared.task["timeoutReset"] = { // 24시간 동안 조작하지 않으면 초기화하는 코드 예약
                    withAnimation { timerVM.timerModel.isTimerViewShowing.toggle() } completion: { timerVM.reset() }
                }
            }
        }
    }
}

#Preview {
    TimerView(timerVM: TimerVM())
}
