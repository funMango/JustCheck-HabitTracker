//
//  TodayListViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import Foundation
import Combine

class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var manager: HabitManageInteractor
    
    init(habits: [Habit] = [], manager: HabitManageInteractor) {
        self.manager = manager
    }
    
    func fetchHabits(_ habits: [Habit]) {
        self.habits = habits
    }
    
    func deleteHabit(_ habit: Habit) {
        Task {
            try await manager.delete(habit)
        }
    }
}
