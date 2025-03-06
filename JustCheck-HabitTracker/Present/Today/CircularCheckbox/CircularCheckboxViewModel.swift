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
        currentTask?.cancel()
                    
        currentTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            if isChecked {
                self.addCheckDay(to: habit)
            }
        }
                    
        if let task = currentTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: task)
        }
    }
    
    private func addCheckDay(to habit: Habit) {
        Task {
            habit.addChecDay(Date())
            try await habitManager.update(habit)
        }
    }
}

