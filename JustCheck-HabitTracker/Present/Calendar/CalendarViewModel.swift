//
//  CalendarViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/11/25.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var checkDaysCount: Int = 0
    var habit: Habit
    private var filter: HabitCheckDaysFilterInteractor
            
    init(habit: Habit, filter: HabitCheckDaysFilterInteractor) {
        self.habit = habit
        self.filter = filter
        self.checkDaysCount = filter.filterCheckDaysCount(
            selectdDate: selectedDate,
            checkDays: habit.checkDays
        )
    }
    
    func setSelectedDate(_ date: Date) {
        self.selectedDate = date
        self.checkDaysCount = filter.filterCheckDaysCount(
            selectdDate: self.selectedDate,
            checkDays: self.habit.checkDays
        )
    }
}
