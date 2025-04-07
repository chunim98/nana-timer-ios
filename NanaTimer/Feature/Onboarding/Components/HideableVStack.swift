//
//  HideableVStack.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/23/25.
//

import SwiftUI

struct HideableVStack<Content: View>: View {
    
    // MARK: Properties
    
    private let isHidden: Bool
    private let content: () -> Content
    
    // MARK: Initalizer
    
    init(
        isHidden: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.isHidden = isHidden
    }
       
    // MARK:  View
    
    var body: some View {
        if !isHidden { VStack(content: content) }
    }
}
