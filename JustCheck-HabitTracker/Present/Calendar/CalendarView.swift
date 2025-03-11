//
//  CalendarView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/7/25.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject private var viewModel: CalendarViewModel    
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            CalendarContentView()
                            
            HStack {
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .padding(.trailing, -5)
                    .foregroundStyle(.gray)
                
                Text("\(viewModel.checkDaysCount)")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 5)
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    let habit = Habit(
        title: "운동하기",
        checkDays: [
            Calendar.current.date(byAdding: .day, value: -10, to: Date())!.startOfDay(), // 10일 전
            Calendar.current.date(byAdding: .day, value: -7, to: Date())!.startOfDay(),  // 7일 전
            Calendar.current.date(byAdding: .day, value: -5, to: Date())!.startOfDay(),  // 5일 전
            Calendar.current.date(byAdding: .day, value: -3, to: Date())!.startOfDay(),  // 3일 전
            Calendar.current.date(byAdding: .day, value: -1, to: Date())!.startOfDay(),  // 어제
            Date().startOfDay(),                                                        // 오늘
            Calendar.current.date(byAdding: .day, value: 1, to: Date())!.startOfDay(),   // 1일 후
            Calendar.current.date(byAdding: .day, value: 2, to: Date())!.startOfDay(),   // 2일 후
            Calendar.current.date(byAdding: .day, value: 5, to: Date())!.startOfDay(),   // 5일 후
            Calendar.current.date(byAdding: .day, value: 10, to: Date())!.startOfDay()   // 10일 후
        ]
    )
    
    let viewModel = CalendarViewModel(
        habit: habit,
        filter: HabitCheckDaysFilter()
    )
    
    CalendarView(viewModel: viewModel)
}
