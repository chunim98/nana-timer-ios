//
//  HideableVStack.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

struct HideableVStack<Content: View>: View {
    
    private let isHidden: Bool
    private let content: () -> Content
    
    init(
        _ isHidden: Bool,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
        self.isHidden = isHidden
    }
       
    var body: some View {
        if !isHidden { VStack(content: content) }
    }
}
