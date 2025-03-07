//
//  HabitFilter.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/6/25.
//

import Foundation

protocol HabitFilterInteractor {
    func filter(habits: [Habit], weekday: Weekday, date: Date) -> [Habit]
}

class HabitFilter: HabitFilterInteractor {    
    func filter(habits: [Habit], weekday: Weekday, date: Date) -> [Habit] {
        return filterByWeekday(habits: habits, by: weekday)        
    }
        
    private func filterByWeekday(habits: [Habit], by weekday: Weekday) -> [Habit] {
        return habits.filter { $0.weekDays.contains(weekday) }
    }
    
    private func filterByDate(habits: [Habit], by date: Date) -> [Habit] {
        return habits.filter { habit in
            let calendar = Calendar.current
            let normalizedDate = calendar.startOfDay(for: date)
            return !habit.checkDays.contains { calendar.isDate($0, inSameDayAs: normalizedDate) }
        }
    }
}
