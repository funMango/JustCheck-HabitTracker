//
//  CalendarMonthView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/12/25.
//

import SwiftUI

struct CalendarMonthView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    
    var body: some View {
        HStack {
            Button(action: { viewModel.changeMonth(by: -1) }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.gray)
            }
                        
            Text("\(yearString(from: viewModel.selectedDate))년 \(monthString(from: viewModel.selectedDate))월")
                .font(.title3)
                .bold()
            
            Button(action: { viewModel.changeMonth(by: 1) }) {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }        
    }
}

extension CalendarMonthView {
    private func monthString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter.string(from: date)
    }
    
    private func yearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter.string(from: date)
    }
}

#Preview {
    let habit = Habit(title: "test")
    let viewModel = CalendarViewModel(habit: habit, filter: HabitCheckDaysFilter())
    
    CalendarMonthView()
        .environmentObject(viewModel)
}
