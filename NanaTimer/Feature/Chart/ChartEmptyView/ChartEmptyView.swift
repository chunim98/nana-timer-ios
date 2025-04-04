//
//  ChartEmptyView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/3/25.
//

import SwiftUI

struct ChartEmptyView: View {
    
    // MARK: State
    
    private let tintColor: Color
    
    // MARK: Init
    
    init(tintColor: Color) {
        self.tintColor = tintColor
    }
    
    // MARK: View
    
    var body: some View {
        VStack {
            Image(systemName: "questionmark.folder.fill").resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(tintColor)
                .frame(height: 100)
                .padding()
            
            Text("아직 공부 현황이 없는 것 같아요")
                .foregroundStyle(Color.textGray)
                .multilineTextAlignment(.center)
                .font(.localizedFont18)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ChartEmptyView(tintColor: .accentColor)
}
