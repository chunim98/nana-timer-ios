//
//  AchievementRateView.swift
//  NanaTimer
//
//  Created by 신정욱 on 4/2/25.
//

import SwiftUI

struct AchievementRateView: View {
    
    // MARK: Properties
    
    private let achievementRate: Int
    private let elapsedDayText: LocalizedStringKey
    private let tintColor1: Color
    private let tintColor2: Color
    
    // MARK: Initializer
    
    init(
        duration: Float,
        elapsedTime: Float,
        elapsedDay: Int,
        timerState: TimerState,
        tintColor1: Color,
        tintColor2: Color
    ) {
        self.achievementRate = {
            duration == 0 ? 0 : Int((elapsedTime/duration)*100)
        }()
        
        self.elapsedDayText = {
            switch elapsedDay {
            case let day where day <= 7 && timerState == .finished:
                return "성공(\(day)일차)"
                
            case let day where day == 7:
                return "마지막 날(\(day)일차)"
                
            case let day where day > 7:
                return "실패(\(day)일차)"
                
            default:
                return "\(elapsedDay)일차"
            }
        }()
        
        self.tintColor1 = tintColor1
        self.tintColor2 = tintColor2
    }
    
    // MARK: View
    
    var body: some View {
        HStack {
            Text("\(achievementRate)%")
                .padding(10)
                .font(.localizedFont18)
                .foregroundStyle(Color.backgroundBeige)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(tintColor1)
                }
            
            Text(elapsedDayText)
                .padding(10)
                .font(.localizedFont18)
                .foregroundStyle(Color.backgroundBeige)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(tintColor2)
                }
        }
    }
}

#Preview {
    AchievementRateView(
        duration: 9,
        elapsedTime: 8.999,
        elapsedDay: 7,
        timerState: .finished,
        tintColor1: .palette[1],
        tintColor2: .palette[2]
    )
}
