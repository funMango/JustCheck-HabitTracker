//
//  TodayListViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import Foundation
import Combine

class TodayListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var habitManager: HabitManageInteractor
    private var weekdayManager: WeekdayManageInteractor
    private var habitFilter: HabitFilterInteractor
    private var cancellables = Set<AnyCancellable>()
    
    init(habitManager: HabitManageInteractor, weekdayManager: WeekdayManageInteractor, habitFilter: HabitFilterInteractor) {
        self.habitManager = habitManager
        self.weekdayManager = weekdayManager
        self.habitFilter = habitFilter
        
        subscribeToUpdateSubject()
    }
    
    func fetchHabits(_ habits: [Habit]) {
        let weekday = weekdayManager.getWeekday(from: Date())                        
        self.habits = habitFilter.filter(habits: habits, weekday: weekday, date: Date())
    }
    
    private func subscribeToUpdateSubject() {
        habitManager.updateSubject
            .sink { [weak self] habits in
                self?.fetchHabits(habits)
            }
            .store(in: &cancellables)
    }
}
