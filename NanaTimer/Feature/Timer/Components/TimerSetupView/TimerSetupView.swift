//
//  TimerSetupView.swift
//  NanaTimer
//
//  Created by 신정욱 on 1/4/25.
//

import SwiftUI
import Combine

struct TimerSetupView: View {
    
    // MARK: Properties
    
    @ObservedObject private var vm = TimerSetupVM()
    private let parentIntent: PassthroughSubject<TimerVM.Intent, Never>
    
    // MARK: Init
    
    init(_ intent: PassthroughSubject<TimerVM.Intent, Never>) {
        self.parentIntent = intent
    }
    
    // MARK: View
    
    var body: some View {
        VStack {
            // x 모양 버튼
            Button {
                parentIntent.send(.closeSetupViewButtonTapped)
                
            } label: {
                Image(systemName: "multiply.circle.fill").resizable()
                    .foregroundStyle(vm.state.tintColor)
                    .frame(width: 50, height: 50)
            }
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
            
            Spacer()
                        
            // 피커 뷰 가로 스택
            HStack {
                // 시간
                VStack {
                    let selectionBinding = Binding(
                        get: { vm.state.hourSelection },
                        set: { vm.intent.send(.hourPickerSwiped($0)) }
                    )
                    
                    Picker("시간", selection: selectionBinding) {
                        ForEach(vm.state.hours, id: \.self) { Text("\($0)") }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("\(vm.state.hourSelection)시간")
                        .foregroundColor(Color.chuText)
                        .font(.localizedFont24)
                }
                
                // 분
                VStack {
                    let selectionBinding = Binding(
                        get: { vm.state.minuteSelection },
                        set: { vm.intent.send(.minutePickerSwiped($0)) }
                    )
                    
                    Picker("분", selection: selectionBinding) {
                        ForEach(vm.state.minutes, id: \.self) { Text("\($0)") }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("\(vm.state.minuteSelection)분")
                        .foregroundColor(Color.chuText)
                        .font(.localizedFont24)
                }
            }
            
            Spacer()
            
            // 결정 버튼
            ComfirmButton(vm.state) {
                parentIntent.send(.confirmButtonTapped(vm.state.selectionSum))
            }
            
            Spacer()
            
            // 사용 안내 텍스트
            Text("Tip. 7일 동안 공부할 시간을 설정하면 돼요")
                .foregroundColor(Color.chuText.opacity(0.5))
                .multilineTextAlignment(.center)
                .font(.localizedFont16)
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.chuSubBack)
                .stroke(Color.chuSubBackShade, lineWidth: 0.5)
        }
    }
}

#Preview {
    TimerSetupView(.init())
}
