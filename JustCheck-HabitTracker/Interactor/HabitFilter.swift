//
//  HabitFilter.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/6/25.
//

import Foundation

protocol HabitFilterInteractor {
    func filter(habits: [Habit], weekday: Weekday) -> [Habit]
}

class HabitFilter: HabitFilterInteractor {    
    func filter(habits: [Habit], weekday: Weekday) -> [Habit] {
        return filterByWeekday(habits: habits, by: weekday)        
    }
        
    private func filterByWeekday(habits: [Habit], by weekday: Weekday) -> [Habit] {
        return habits.filter { $0.weekDays.contains(weekday) }
    }
}
