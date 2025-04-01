//
//  SetupState.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/31/25.
//

import Foundation

enum SetupState: Int {
    case notConfigured // 아직 타이머를 구성하지 않은 상태
    case configuring   // 타이머를 구성하는 중인 상태
    case configured    // 타이머 구성이 완료된 상태
}
