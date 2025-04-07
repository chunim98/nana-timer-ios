//
//  ComfirmButton.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/1/25.
//

import SwiftUI
import Combine

struct ComfirmButton: View {
    
    // MARK: Properties
    
    private let isDisabled: Bool
    private let tintColor: Color
    private let perform: () -> Void
    
    // MARK: Initializer
    
    init(
        isDisabled: Bool,
        tintColor: Color,
        perform: @escaping () -> Void
    ) {
        self.isDisabled = isDisabled
        self.tintColor = tintColor.opacity(isDisabled ? 0.5 : 1.0)
        self.perform = perform
    }
    
    // MARK: View
    
    var body: some View {
        Button {
            perform()
            
        } label: {
            Text("결정")
                .font(.localizedFont28)
                .foregroundStyle(Color.pageIvory)
                .padding(EdgeInsets(horizontal: 15, vertical: 10))
                .background { RoundedRectangle(cornerRadius: 25).fill(tintColor) }
        }
        .disabled(isDisabled)
        .animation(.default, value: isDisabled)
    }
}

#Preview {
    ComfirmButton(
        isDisabled: false,
        tintColor: .textBlack,
        perform: {}
    )
}
