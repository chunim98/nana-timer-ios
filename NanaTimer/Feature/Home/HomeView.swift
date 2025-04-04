//
//  HomeView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 5/30/24.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.scenePhase) private var scenePhase: ScenePhase

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
                        // 도메인 로직과 직결된 핵심 뷰, TimerVM이 존재하는 이유
                        TimerView(timerVM).tag(0)
                        
                        // 차트를 표시하는 뷰
                        ChartView(
                            screenState: timerVM.state.screenState,
                            dailyStudyTimes: timerVM.state.dailyStudyTimes,
                            tintColors: timerVM.state.colors
                        )
                        .tag(1)
                    }
                }
            }
            .background { Color.backgroundBeige.ignoresSafeArea() }
            .onAppear { homeVM.intent.send(.onAppear) }
            .onChange(of: scenePhase) { _, new in
                timerVM.intent.send(.scenePhaseUpdated(new))
            }
            .navigationDestination(for: String.self) {
                if $0 == "SV" { SettingsView(settingsVM: .init()) }
            }
        }
        .tint(.textBlack) // 네비게이션 백 버튼 색상에 관여
    }
}



#Preview {
    HomeView()
}
