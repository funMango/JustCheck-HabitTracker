//
//  TodayListViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import Foundation

class TodayListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var weekdayManager: WeekdayManageInteractor
    private var habitFilter: HabitFilterInteractor
    
    init(weekdayManager: WeekdayManageInteractor, habitFilter: HabitFilterInteractor) {
        self.weekdayManager = weekdayManager
        self.habitFilter = habitFilter
    }
    
    func fetchHabits(_ habits: [Habit]) {
        let weekday = weekdayManager.getWeekday(from: Date())                        
        self.habits = habitFilter.filter(habits: habits, weekday: weekday, date: Date())
    }
}
