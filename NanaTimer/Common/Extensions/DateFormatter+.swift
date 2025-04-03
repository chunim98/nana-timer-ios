//
//  DateFormatter+.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import Foundation

extension DateFormatter {
    static let shared = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}
