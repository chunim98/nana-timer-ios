//
//  SettingsModel.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

struct SettingsModel {
    @Storage("isAuthorized", false) var isAuthorized: Bool // 기본값 false
    @Storage("isOnNotify", true) var isOnNotify: Bool // 커스텀 기본값 true
    @Storage("isOnTactile", false) var isOnTactile: Bool
    @Storage("notiInterval", 60) var notiInterval: Int // 커스텀 기본값 60
    
    var colorPalette: [Color] = Color.palette
    
    init() {
        self.colorPalette.shuffle()
    }

}
