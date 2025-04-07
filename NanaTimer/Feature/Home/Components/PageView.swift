//
//  PageView.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/31/25.
//

import SwiftUI
import Combine

struct PageView<Content: View>: View {
    
    // MARK: Properties
    
    private let pageIndex: Int
    private var indicatorColors: [Color]
    private let intent: PassthroughSubject<HomeVM.Intent, Never>
    private let content: () -> Content
    
    // MARK: Initializer
    
    init(
        pageIndex: Int,
        intent: PassthroughSubject<HomeVM.Intent, Never>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.indicatorColors = (0..<2).map {
            $0 == pageIndex ? .textBlack : .textBlack.opacity(0.25)
        }
        self.pageIndex = pageIndex
        self.intent = intent
        self.content = content
    }
    
    // MARK: View
    
    var body: some View {
        // Properties
        let pageSelectionBinding = Binding(
            get: { pageIndex },
            set: { intent.send(.pageSwiped($0)) }
        )
        
        // View
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
                .onTapGesture { intent.send(.pageIndicatorSelected(0)) }
            
            Spacer().frame(width: 30)
            
            Image(systemName: "chart.bar.fill").resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(indicatorColors[1])
                .onTapGesture { intent.send(.pageIndicatorSelected(1)) }
        }
        .frame(height: 20)
        .animation(.easeInOut(duration: 0.25), value: pageIndex)
    }
}

#Preview {
    PageView(pageIndex: 1, intent: .init(), content: {})
}
