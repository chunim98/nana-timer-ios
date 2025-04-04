//
//  SettingsView.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var settingsVM: SettingsVM
    
    var body: some View {
        GeometryReader{ geo in
            List {
                //MARK: -  Notification Settings
                
                Section (header: Text("알림").bold()) {
                    VStack(alignment: .leading) {
                        Toggle(String(localized: "타이머 상태 알림"), isOn: $settingsVM.settingsModel.isOnNotify)
                            .toggleStyle(SwitchToggleStyle(tint: settingsVM.settingsModel.colorPalette[0]))
                        Text("타이머 정지를 잊지 않도록 푸시 알림을 받습니다.")
                            .font(.system(size: 14))
                            .padding(.top, 3)
                            .foregroundStyle(Color.gray)
                    }
                    .listRowBackground(Color.pageIvory)
                    .disabled(!settingsVM.settingsModel.isAuthorized)

                    VStack(alignment: .leading) {
                        Picker("반복", selection: $settingsVM.settingsModel.notiInterval) {
                            let interval = [30, 60, 90, 120]
                            ForEach(interval, id: \.self) { Text("\($0)분마다") }
                        }
                    }
                    .listRowBackground(Color.pageIvory)
                    .disabled(!settingsVM.settingsModel.isAuthorized || !settingsVM.settingsModel.isOnNotify)
                }
                
                //MARK: -  ect Settings

                Section (header: Text("기타").bold()) {
                    VStack(alignment: .leading) {
                        Toggle(String(localized: "촉각 피드백"), isOn: $settingsVM.settingsModel.isOnTactile)
                            .toggleStyle(SwitchToggleStyle(tint: settingsVM.settingsModel.colorPalette[0]))
                        Text("타이머 작동 중 매초 햅틱 피드백이 발생합니다.")
                            .font(.system(size: 14))
                            .padding(.top, 3)
                            .foregroundStyle(Color.gray)
                    }
                    .listRowBackground(Color.pageIvory)
                }
                
                //MARK: -  If Not Authorized

                if !settingsVM.settingsModel.isAuthorized {
                    VStack{
                        Text("알림을 사용할 수 없어요.")
                            .foregroundStyle(.gray)
                            .font(.headline)
                        
                        Text("앱 설정에서 알림을 허용하고 다시 시도해 주세요.")
                            .foregroundStyle(.gray)
                            .font(.system(size: 14))
                            .padding(1)
                        
                        Button(action: { settingsVM.directAppSetting(); dismiss() }, label: {
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
            .background(Color.backgroundBeige.ignoresSafeArea())
            .onAppear() { settingsVM.checkAuthorized() }
            
            // 네비게이션 바 설정
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView(settingsVM: SettingsVM())
}
