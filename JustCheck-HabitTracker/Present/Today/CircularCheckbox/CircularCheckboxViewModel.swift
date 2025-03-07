//
//  CircularCheckboxViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/6/25.
//

import Foundation

class CircularCheckboxViewModel: ObservableObject {
    private var habitManager: HabitManageInteractor
    private var currentTask: DispatchWorkItem?
    
    init(habitManager: HabitManageInteractor) {
        self.habitManager = habitManager
    }
            
    func check(_ habit: Habit, isChecked: Bool) {
        if isChecked {
            self.addCheckDay(to: habit)
        } else {
            self.removeCheckDay(from: habit)
        }
    }
    
    private func addCheckDay(to habit: Habit) {
        Task {
            habit.addCheckDay(Date())
            try await habitManager.update(habit)
        }
    }
    
    private func removeCheckDay(from habit: Habit) {
        Task {
            await habit.removeCheckDay(Date())
            try await habitManager.update(habit)
        }
    }
}

