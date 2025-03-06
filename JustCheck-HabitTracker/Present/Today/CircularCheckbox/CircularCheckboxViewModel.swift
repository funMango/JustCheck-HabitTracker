//
//  CircularCheckboxViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/6/25.
//

import Foundation

class CircularCheckboxViewModel: ObservableObject {
    private var habitManager: HabitManageInteractor
    
    init(habitManager: HabitManageInteractor) {
        self.habitManager = habitManager
    }
    
    func check(_ habit: Habit) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.addCheckDay(to: habit)
        }
    }
    
    private func addCheckDay(to habit: Habit) {
        Task {
            habit.addChecDay(Date())
            try await habitManager.update(habit)
        }
    }
}

