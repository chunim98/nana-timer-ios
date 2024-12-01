//
//  SetVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

final class SetVM: ObservableObject {
    
    @Published var setModel = SetModel()
    
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
                    self?.setModel.isAuthorized = true
                    
                case .denied, .ephemeral, .notDetermined, .provisional:
                    self?.setModel.isAuthorized = false
                    
                @unknown default:
                    print("알림허가 예외")
                }
            }
        }
    }
}
