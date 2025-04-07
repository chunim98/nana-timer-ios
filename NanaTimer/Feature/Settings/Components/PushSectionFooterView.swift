//
//  PushSectionFooterView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/5/25.
//

import SwiftUI

struct PushSectionFooterView: View {
    
    // MARK: Properties
    
    private let isAuthorized: Bool
    private let perform: () -> Void
    
    // MARK: Initializer
    
    init(
        isAuthorized: Bool,
        perform: @escaping () -> Void
    ) {
        self.isAuthorized = isAuthorized
        self.perform = perform
    }
    
    // MARK: View
    
    var body: some View {
        if !isAuthorized {
            HStack {
                Text("앱 설정에서 알림을 허용해주세요.")
                    .foregroundStyle(.gray)
                    .font(.system(size: 14))
                
                Spacer()
                
                Button {
                    perform()
                    
                } label: {
                    Text("설정으로 이동")
                        .foregroundStyle(.blue)
                        .font(.system(size: 14))
                        .underline()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
