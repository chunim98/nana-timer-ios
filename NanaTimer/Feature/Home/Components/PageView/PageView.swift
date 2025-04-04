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
    private var indicatorColors: [Color]
    
    // MARK: Properties
    
    private let parentIntent: PassthroughSubject<HomeVM.Intent, Never>
    private let content: () -> Content
    
    // MARK: Init
    
    init(
        pageIndex: Int,
        _ intent: PassthroughSubject<HomeVM.Intent, Never>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.indicatorColors = (0..<2).map {
            $0 == pageIndex ? .textBlack : .textBlack.opacity(0.25)
        }
        self.pageIndex = pageIndex
        self.parentIntent = intent
        self.content = content
    }
    
    // MARK: View
    
    var body: some View {
        let pageSelectionBinding = Binding(
            get: { pageIndex },
            set: { parentIntent.send(.pageSwiped($0)) }
        )
        
        // 페이지 뷰
        TabView(selection: pageSelectionBinding) {
            Group { content() }.padding(15)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 1.0), value: pageIndex)
        
        // 인덱스 뷰
        HStack {
            Image(systemName: "clock.fill").resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(indicatorColors[0])
                .onTapGesture { parentIntent.send(.pageIndicatorSelected(0)) }
            
            Spacer().frame(width: 30)
            
            Image(systemName: "chart.bar.fill").resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(indicatorColors[1])
                .onTapGesture { parentIntent.send(.pageIndicatorSelected(1)) }
        }
        .frame(height: 20)
        .animation(.easeInOut(duration: 0.25), value: pageIndex)
    }
}

#Preview {
    PageView(pageIndex: 1, .init(), content: {})
}
