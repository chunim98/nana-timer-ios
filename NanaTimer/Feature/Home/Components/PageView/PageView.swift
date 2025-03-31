//
//  PageView.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/31/25.
//

import SwiftUI
import Combine

struct PageView<Content: View>: View {
    
    // MARK: State
    
    private let pageIndex: Int
    private var colors: [Color]
    
    // MARK: Properties
    
    private let intent: PassthroughSubject<Home.Intent, Never>
    private let content: () -> Content
    
    // MARK: Init
    
    init(
        _ pageIndex: Int,
        _ intent: PassthroughSubject<Home.Intent, Never>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.pageIndex = pageIndex
        self.colors = (0..<2).map { $0 == pageIndex ? .chuText : .chuText.opacity(0.25) }
        self.intent = intent
        self.content = content
    }
    
    // MARK: View
    
    var body: some View {
        let binding = Binding(
            get: { pageIndex },
            set: { intent.send(.pageSwiped($0)) }
        )
        
        // 페이지 뷰
        TabView(selection: binding) {
            Group { content() }.padding(15)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 1.0), value: pageIndex)
        
        // 인덱스 뷰
        HStack {
            Image(systemName: "clock.fill").resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(colors[0])
                .onTapGesture { intent.send(.pageIndicatorSelected(0)) }
            
            Spacer().frame(width: 30)
            
            Image(systemName: "chart.bar.fill").resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(colors[1])
                .onTapGesture { intent.send(.pageIndicatorSelected(1)) }
        }
        .frame(height: 20)
        .animation(.easeInOut(duration: 0.25), value: pageIndex)
    }
}

#Preview {
    PageView(1, .init(), content: {})
}
