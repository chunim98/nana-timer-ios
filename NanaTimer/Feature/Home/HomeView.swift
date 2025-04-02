//
//  HomeView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 5/30/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var chartVM: ChartVM // temp
    
    @StateObject private var homeVM = HomeVM()
    @StateObject private var timerVM = TimerVM()
    
    var body: some View {
        let pathBindig = Binding(
            get: { homeVM.state.navigationPath },
            set: { _ in homeVM.intent.send(.setttingsViewClosed) }
        )
        
        NavigationStack(path: pathBindig) {
            ZStack {
                // 최초 실행 시, 노출되는 온보딩 화면
                OnboardingView().zIndex(999) // z레이어 우선순위 (높을수록 앞에 옴)
                
                VStack {
                    // 네비게이션 바와 비슷한 역할의 뷰
                    StatusView(
                        pageIndex: homeVM.state.currentPageIndex,
                        timerState: timerVM.state.timerState,
                        homeVM.intent
                    )
                    
                    // 커스텀 인덱스 뷰가 적용된 페이지 스타일의 탭 뷰
                    PageView(
                        pageIndex: homeVM.state.currentPageIndex,
                        homeVM.intent
                    ) {
                        TimerView(timerVM).tag(0)
                        ChartView(chartVM: chartVM).tag(1)
                    }
                }
            }
            .background { Color.chuBack.ignoresSafeArea() }
            .onAppear { homeVM.intent.send(.onAppear) }
            .navigationDestination(for: String.self) {
                if $0 == "SettingsView" { SettingsView(settingsVM: .init()) }
            }
        }
        .tint(.chuText) // 네비게이션 백 버튼 색상에 관여
    }
}



#Preview {
    HomeView(chartVM: .init())
}
