//
//  HomeVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 3/29/25.
//

import SwiftUI
import UIKit
import Combine

final class HomeVM: ObservableObject {
    
    struct State {
        var currentPageIndex = 0
        var navigationPath = [String]()
    }
    
    enum Intent {
        case pageIndicatorSelected(Int)
        case pageSwiped(Int)
        case settingsButtonTapped
        case setttingsViewClosed
        case onAppear
    }
    
    // MARK: Properties
    
    @Published private(set) var state = State()
    let intent = PassthroughSubject<Intent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let timer = TimerHelper()

    // MARK: Life Cycle
    
    init() {
        intent // 인텐트 바인딩
            .print("HomeVM")
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
            
        case .onAppear:
            configureNavigationBar()
            PushNotificationManager.shared.requestAuthorization()
        }
    }
    
    // MARK: Methods
    
    private func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(Color.chuText)
        ]
        navigationBarAppearance.backgroundColor = UIColor(Color.chuBack)
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
