//
//  CalendarContentView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/11/25.
//

import SwiftUI

struct CalendarContentView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
        
    var body: some View {
        VStack {
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
                
                Text("\(yearString(from: viewModel.selectedDate))년 \(monthString(from: viewModel.selectedDate))월")
                    .font(.title2)
                    .bold()
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Weekday.allCases, id: \.self) { weekday in
                    Text(weekday.localized)
                        .frame(maxWidth: .infinity)
                        .bold()
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)
            
            LazyVGrid(columns: columns, spacing: 10) {
                let allDays = daysInMonth()
                
                ForEach(allDays.indices, id: \.self) { index in
                    if let date = allDays[index] {
                        Text(dayString(from: date))
                            .foregroundStyle(viewModel.habit.checkDays.contains(date.startOfDay()) ? Color.whiteBlack : Color.primary)
                            .frame(width: 35, height: 35)
                            .background(viewModel.habit.checkDays.contains(date.startOfDay()) ? Color.blackWhite : Color.clear)
                            .clipShape(Circle())
                    } else {
                        Text("")
                            .frame(width: 35, height: 35)
                    }
                }
            }
        }        
    }
}

extension CalendarContentView {
    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: viewModel.selectedDate) {
            viewModel.setSelectedDate(newDate)
        }
    }
    
    private func daysInMonth() -> [Date?] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: viewModel.selectedDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth) - 1
        let startOffset = (firstWeekday + 6) % 7
        
        var days: [Date?] = Array(repeating: nil, count: startOffset)
        days.append(contentsOf: (1...range.count).compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        })
        
        while days.count % 7 != 0 {
            days.append(nil)
        }
        
        return days
    }
    
    private func dayString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
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

