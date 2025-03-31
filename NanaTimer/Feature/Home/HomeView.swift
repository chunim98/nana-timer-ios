//
//  HomeView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 5/30/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM: HomeVM
    var timerVM: TimerVM
    @StateObject var chartVM: ChartVM
    
    @StateObject private var home = Home()
    
    var body: some View {
        let pathBindig = Binding(
            get: { home.state.navigationPath },
            set: { _ in home.intent.send(.setttingsViewClosed) }
        )
        
        NavigationStack(path: pathBindig) {
            ZStack {
                // 최초 실행 시, 노출되는 온보딩 화면
                OnboardingView().zIndex(999) // z레이어 우선순위 (높을수록 앞에 옴)
                
                VStack {
                    // 네비게이션 바와 비슷한 역할을 하는 뷰
                    StatusView(home.state.currentPageIndex, .idle, home.intent)
                    
                    // 커스텀 인덱스 뷰가 적용된 페이지 스타일의 탭 뷰
                    PageView(home.state.currentPageIndex, home.intent) {
                        TimerView(timerVM: timerVM).tag(0)
                        ChartView(chartVM: chartVM).tag(1)
                    }
                }
            }
            .animation(.bouncy, value: timerVM.timerModel.settedTime) // 하위뷰에 애니메이션 성질이 상속되니 조심해서 쓰자
            .background(Color.chuBack.ignoresSafeArea())
            .onAppear() {
                PushNotificationManager.shared.requestAuthorization()
                homeVM.configureNavigationViewStyle()
            }
            .navigationDestination(for: String.self) {
                if $0 == "SettingsView" { SettingsView(settingsVM: .init()) }
            }
        }
        .tint(Color.chuText) // 네비게이션 백버튼 색 바꾸는 용도, 전체적으로 엑센트 컬러가 바뀌어버림
    }
}



#Preview {
    HomeView( homeVM: HomeVM(), timerVM: TimerVM(), chartVM: ChartVM())
}
