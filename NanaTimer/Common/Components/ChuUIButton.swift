//
//  ChuUIButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 12/14/24.
//


import SwiftUI

struct ChuUIButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.pageDarkIvory)
                        .stroke(Color.pageDarkIvory, lineWidth: 0.5)
                        .offset(y: configuration.isPressed ? 0 : 5)
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.pageIvory)
                        .stroke(Color.pageDarkIvory, lineWidth: 0.5)
                })
            .offset(y: configuration.isPressed ? 5 : 0)
            .offset(y: -5)
    }
}
