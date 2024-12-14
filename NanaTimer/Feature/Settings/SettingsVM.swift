//
//  SettingsVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

@preconcurrency
import SwiftUI

final class SettingsVM: ObservableObject {
    
    @Published var settingsModel = SettingsModel()
    
    func directAppSetting() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    func checkAuthorized() {
        Task {
            let settings = await PushNotificationManager.shared.getNotificationSettings()
            
            // @Published 값 업뎃은 메인스레드에서 해줘야 함, UIKit도 뷰 업뎃은 메인에서 하잖아?
            DispatchQueue.main.async { [weak self] in
                switch settings.authorizationStatus {
                case .authorized:
                    self?.settingsModel.isAuthorized = true
                    
                case .denied, .ephemeral, .notDetermined, .provisional:
                    self?.settingsModel.isAuthorized = false
                    
                @unknown default:
                    print("알림허가 예외")
                }
            }
        }
    }
}
