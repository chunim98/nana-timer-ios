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
    private let timerVMIntent: PassthroughSubject<TimerVM.Intent, Never>
    
    // MARK: Initializer
    
    init(intent: PassthroughSubject<TimerVM.Intent, Never>) {
        self.timerVMIntent = intent
    }
    
    // MARK: View
    
    var body: some View {
        // Properties
        let hoursSelectionBinding = Binding(
            get: { vm.state.hourSelection },
            set: { vm.intent.send(.hourPickerSwiped($0)) }
        )
        let minutesSelectionBinding = Binding(
            get: { vm.state.minuteSelection },
            set: { vm.intent.send(.minutePickerSwiped($0)) }
        )
        
        // View
        VStack {
            // x 모양 버튼
            Button {
                timerVMIntent.send(.closeSetupViewButtonTapped)
                
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
                    Picker("시간", selection: hoursSelectionBinding) {
                        ForEach(vm.state.hours, id: \.self) { Text("\($0)") }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("\(vm.state.hourSelection)시간")
                        .foregroundStyle(Color.textBlack)
                        .font(.localizedFont24)
                }
                
                // 분
                VStack {
                    Picker("분", selection: minutesSelectionBinding) {
                        ForEach(vm.state.minutes, id: \.self) { Text("\($0)") }
                    }
                    .pickerStyle(.wheel)
                    
                    Text("\(vm.state.minuteSelection)분")
                        .foregroundStyle(Color.textBlack)
                        .font(.localizedFont24)
                }
            }
            
            Spacer()
            
            // 결정 버튼
            ComfirmButton(
                isDisabled: vm.state.isConfirmButtonDiabled,
                tintColor: vm.state.tintColor
            ) {
                timerVMIntent.send(.confirmButtonTapped(vm.state.selectionSum))
            }
            
            Spacer()
            
            // 사용 안내 텍스트
            Text("Tip. 7일 동안 공부할 시간을 설정하면 돼요")
                .foregroundStyle(Color.textGray)
                .multilineTextAlignment(.center)
                .font(.localizedFont16)
        }
        .padding(15)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.pageIvory)
                .stroke(Color.pageDarkIvory, lineWidth: 0.5)
        }
    }
}

#Preview {
    TimerSetupView(intent: .init())
}
