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
                CalendarMonthView()
                    .environmentObject(viewModel)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Text(String(localized: "detail"))
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding()
            
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
                            .foregroundStyle(viewModel.habit.checkDays.contains(date.startOfDay()) ? .white : .primary)
                            .frame(width: 35, height: 35)
                            .background(viewModel.habit.checkDays.contains(date.startOfDay()) ? Color.blackGray : Color.clear)
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
    private func daysInMonth() -> [Date?] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: viewModel.selectedDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
                
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let startOffset = firstWeekday - 1
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
    
    CalendarContentView()
        .environmentObject(viewModel)
}
