//
//  HomeView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 5/30/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM: HomeVM
    @StateObject var timerVM: TimerVM
    @StateObject var chartVM: ChartVM
    
    @State var tabNum = 1

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            if tabNum == 1 {
                                Text(timerVM.statusText)
                                    .font(.chuCustomFont(size: 28))
                                    .foregroundColor(Color.chuText)
                                Spacer()
                            } else if tabNum == 2 {
                                Text(chartVM.titleText)
                                    .font(.chuCustomFont(size: 28))
                                    .foregroundColor(Color.chuText)
                                Text(chartVM.subTitleText)
                                    .font(.chuCustomFont(size: 14))
                                    .foregroundColor(Color.chuText.opacity(0.5))
                                Spacer()
                            }
                 
                            NavigationLink(destination: SettingsView(settingsVM: SettingsVM())) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color.chuText)
                            }
                        }
                        .frame(maxWidth: geo.size.width * 0.9)
                        .padding(.top)
                        
                        TabView (selection: $tabNum) {
                            TimerView(timerVM: timerVM)
                                .frame(maxWidth: geo.size.width * 0.9 , maxHeight: geo.size.height * 0.85)
                                .offset(y: geo.size.height * -0.025)
                                .tabItem { Image(systemName: "clock.fill") }
                                .tag(1)

                            ChartView(chartVM: chartVM)
                                .frame(maxWidth: geo.size.width * 0.9 , maxHeight: geo.size.height * 0.85)
                                .offset(y: geo.size.height * -0.025)
                                .tabItem { Image(systemName: "chart.bar.fill") }
                                .tag(2)

                        }
                        .tabViewStyle(.page(indexDisplayMode: .automatic))
                        .onAppear() {
                            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.chuText)
                            UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.chuText.opacity(0.25))
                        }
                    }
                    OnboardingView()
                }
            }
            .animation(.bouncy, value: timerVM.timerModel.settedTime) // 하위뷰에 애니메이션 성질이 상속되니 조심해서 쓰자
            .background(Color.chuBack.ignoresSafeArea())
            .onAppear() {
                PushNotificationManager.shared.requestAuthorization()
                homeVM.configureNavigationViewStyle()
            }
        }
        .tint(Color.chuText) // 네비게이션 백버튼 색 바꾸는 용도, 전체적으로 엑센트 컬러가 바뀌어버림
    }
}



#Preview {
    HomeView( homeVM: HomeVM(), timerVM: TimerVM(), chartVM: ChartVM())
}
