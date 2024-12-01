//
//  SetView.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

struct SetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var setVM: SetVM
    
    var body: some View {
        GeometryReader{ geo in
            List {
                //MARK: -  Notification Settings
                
                Section (header: Text("알림").bold()) {
                    VStack(alignment: .leading) {
                        Toggle(String(localized: "타이머 상태 알림"), isOn: $setVM.setModel.isOnNotify)
                            .toggleStyle(SwitchToggleStyle(tint: setVM.setModel.colorPalette[0]))
                        Text("타이머 정지를 잊지 않도록 푸시 알림을 받습니다.")
                            .font(.system(size: 14))
                            .padding(.top, 3)
                            .foregroundStyle(Color.gray)
                    }
                    .listRowBackground(Color.chuSubBack)
                    .disabled(!setVM.setModel.isAuthorized)

                    VStack(alignment: .leading) {
                        Picker("반복", selection: $setVM.setModel.notiInterval) {
                            let interval = [30, 60, 90, 120]
                            ForEach(interval, id: \.self) { Text("\($0)분마다") }
                        }
                    }
                    .listRowBackground(Color.chuSubBack)
                    .disabled(!setVM.setModel.isAuthorized || !setVM.setModel.isOnNotify)
                }
                
                //MARK: -  ect Settings

                Section (header: Text("기타").bold()) {
                    VStack(alignment: .leading) {
                        Toggle(String(localized: "촉각 피드백"), isOn: $setVM.setModel.isOnTactile)
                            .toggleStyle(SwitchToggleStyle(tint: setVM.setModel.colorPalette[0]))
                        Text("타이머 작동 중 매초 햅틱 피드백이 발생합니다.")
                            .font(.system(size: 14))
                            .padding(.top, 3)
                            .foregroundStyle(Color.gray)
                    }
                    .listRowBackground(Color.chuSubBack)
                }
                
                //MARK: -  If Not Authorized

                if !setVM.setModel.isAuthorized {
                    VStack{
                        Text("알림을 사용할 수 없어요.")
                            .foregroundStyle(.gray)
                            .font(.headline)
                        
                        Text("앱 설정에서 알림을 허용하고 다시 시도해 주세요.")
                            .foregroundStyle(.gray)
                            .font(.system(size: 14))
                            .padding(1)
                        
                        Button(action: { setVM.directAppSetting(); dismiss() }, label: {
                            Text("설정으로 이동")
                                .foregroundStyle(.blue)
                                .underline()
                        })
                    }
                    .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.chuBack.ignoresSafeArea())
            .onAppear() { setVM.checkAuthorized() }
            
            // 네비게이션 바 설정
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SetView(setVM: SetVM())
}
