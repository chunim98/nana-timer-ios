//
//  FirstOperationView.swift
//  ReverseStopWatch
//
//  Created by 신정욱 on 7/1/24.
//

import SwiftUI

struct FirstOperationView: View {
    @State var isMoving = true
    @State var animationTimer: Timer?
    @State var isAlertShowing = false
    @AppStorage("isFirstOperation") var isFirstOperation = true // 한번만 뜨고 사라지는 화면을 위한 변수
    @State var colorPalette: [Color] = Color.chuColorPalette
    
    var body: some View {
        if isFirstOperation {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Text("반가워요!")
                            .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.3, alignment: .leading)
                            .font(.chuCustomFont(size: 36))
                            .foregroundStyle(Color.chuText)
                            .padding(.leading, geo.size.width * 0.08)
                        Button(action: { isAlertShowing.toggle(); HapticManager.shared.occurLight() }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .trailing)
                                .foregroundStyle(colorPalette[0])
                        })
                        .frame(maxWidth: geo.size.width * 0.2, maxHeight: geo.size.height * 0.3, alignment: .topTrailing)
                        .padding()
                        .alert("창을 닫을까요?\n이 창은 다시 볼 수 없어요", isPresented: $isAlertShowing, actions: {
                            Button("취소", role: .cancel, action: {})
                            Button("닫기") {
                                HapticManager.shared.occurLight()
                                withAnimation{ isFirstOperation = false }
                            completion: { animationTimer?.invalidate(); animationTimer = nil }
                            }
                        })
                    }
                    
                    Image(systemName: "hand.point.up.fill").resizable()
                        .frame(width: 80, height: 100)
                        .foregroundStyle(Color.chuText)
                        .offset(x: isMoving ? 100 : -100)
                        .animation(Animation.easeInOut(duration: 1.5), value: isMoving)
                        .padding()
                    Text("좌우로 밀어서 추가 화면을 볼 수 있어요 :)")
                        .font(.chuCustomFont(size: 18))
                        .foregroundStyle(Color.chuText)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(
                        action: { isAlertShowing.toggle(); HapticManager.shared.occurLight() },
                        label: {
                            Text("닫기")
                                .font(.chuCustomFont(size: 28))
                                .foregroundColor(Color.init(hex: 0xefedeb))
                        })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 50).fill(colorPalette[0]))
                    .padding(50)
                    .alert("창을 닫을까요?\n이 창은 다시 볼 수 없어요", isPresented: $isAlertShowing, actions: {
                        Button("취소", role: .cancel, action: {})
                        Button("닫기") {
                            HapticManager.shared.occurLight()
                            withAnimation{ isFirstOperation = false }
                        completion: { animationTimer?.invalidate(); animationTimer = nil }
                        }
                    })
                    Spacer()

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .onAppear() {
                    animationTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        isMoving.toggle()
                    }
                }
                
            }
            .onAppear() { colorPalette.shuffle() }
            .zIndex(1).transition(.opacity)
        }
    }
}

#Preview {
    FirstOperationView()
}
