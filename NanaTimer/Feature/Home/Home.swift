//
//  Home.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/29/25.
//

import Foundation
import Combine

final class Home: ObservableObject {
    
    struct State {
        var currentPageIndex = 0
        var navigationPath = [String]()
    }
    
    enum Intent {
        case pageIndicatorSelected(Int)
        case pageSwiped(Int)
        case settingsButtonTapped
        case setttingsViewClosed
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Life Cycle
    
    init() {
        // 인텐트 바인딩
        intent
            .print()
            .sink { [weak self] in self?.process($0) }
            .store(in: &cancellables)
    }

    // MARK: Processing
    
    private func process(_ intent: Intent) {
        switch intent {
        case let .pageIndicatorSelected(idx):
            state.currentPageIndex = idx
            
        case let .pageSwiped(idx):
            state.currentPageIndex = idx
            
        case .settingsButtonTapped:
            state.navigationPath = ["SettingsView"]
            
        case .setttingsViewClosed:
            state.navigationPath.removeAll()
        }
    }
}
