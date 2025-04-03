//
//  ChartVM.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/3/25.
//

import SwiftUI
import Combine

//final class ChartVM: ObservableObject {
//    
//    struct State {
//        
//    }
//    
//    enum Intent {}
//    
//    // MARK: Properties
//    
//    @Published private(set) var state = State()
//    let intent = PassthroughSubject<Intent, Never>()
//    private let parentIntent: PassthroughSubject<.Intent, Never>
//    private var cancellables = Set<AnyCancellable>()
//    
//    // MARK: Init
//    
//    init(_ parentIntent: PassthroughSubject<.Intent, Never>) {
//        self.parentIntent = parentIntent
//        
//        intent // 인텐트 바인딩
//            .print("")
//            .sink { [weak self] in self?.process($0) }
//            .store(in: &cancellables)
//    }
//    
//    // MARK: Processing
//    
//    private func process(_ intent: Intent) {
//        switch intent {
//        }
//    }
//}
