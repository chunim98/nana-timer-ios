//
//  SettingsModel.swift
//  NanaTimer
//
//  Created by 신정욱 on 7/11/24.
//

import SwiftUI

struct SettingsModel {
    @BoolStorage("isAuthorized") var isAuthorized: Bool // 기본값 false
    @BoolStorage("isOnNotify", true) var isOnNotify: Bool // 커스텀 기본값 true
    @BoolStorage("isOnTactile") var isOnTactile: Bool
    @IntStorage("notiInterval", 60) var notiInterval: Int // 커스텀 기본값 60
    
    var colorPalette: [Color] = Color.chuColorPalette
    
    init() {
        self.colorPalette.shuffle()
    }

}
