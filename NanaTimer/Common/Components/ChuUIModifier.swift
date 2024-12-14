//
//  ChuUIModifier.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

struct ChuUIModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.chuSubBack)
                        .stroke(Color.chuSubBackShade, lineWidth: 0.5)
                })
    }
}