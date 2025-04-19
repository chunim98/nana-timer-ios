//
//  ResetButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI

struct ResetButton: View {
    
    // MARK: Propertes
    
    @State private var isAlertPreseted = false
    private let tintColor: Color
    private let perform: () -> Void
    
    // MARK: Initializer
    
    init(
        tintColor: Color,
        perform: @escaping () -> Void
    ) {
        self.tintColor = tintColor
        self.perform = perform
    }
    
    // MARK: View
    
    var body: some View {
        Button {
            HapticManager.shared.occurLight()
            isAlertPreseted.toggle()
            
        } label: {
            Image(systemName: "trash.fill").resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(tintColor)
        }
        .buttonStyle(PressPopButtonStyle())
        .frame(height: 75)
        .alert(
            "초기화할까요?\n이 작업은 되돌릴 수 없어요",
            isPresented: $isAlertPreseted
        ) {
            Button("취소", role: .cancel) {}
            
            Button("초기화") {
                perform()
                HapticManager.shared.occurSuccess()
            }
        }
    }
}

#Preview {
    ResetButton(tintColor: .backgroundBeige, perform: {})
}
