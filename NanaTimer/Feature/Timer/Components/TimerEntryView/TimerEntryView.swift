//
//  TimerEntryView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/3/25.
//

import SwiftUI
import Combine

struct TimerEntryView: View {

    // MARK: Properties
    
    private let intent: PassthroughSubject<TimerVM.Intent, Never>
    
    // MARK: Init
    
    init(_ intent: PassthroughSubject<TimerVM.Intent, Never>) {
        self.intent = intent
    }
    
    // MARK: View
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            intent.send(.setupButtonTapped)
            
        } label: {
            VStack(spacing: 15) {
                Image(systemName: "clock.fill").resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.chuColorPalette.randomElement()!)
                
                Text("타이머를 설정하려면\n가볍게 탭 하세요")
                    .font(.localizedFont28)
                    .foregroundColor(Color.chuText)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.chuSubBack)
                    .stroke(Color.chuSubBackShade, lineWidth: 0.5)
            }
        }
    }
}

#Preview {
    TimerEntryView(.init())
}
