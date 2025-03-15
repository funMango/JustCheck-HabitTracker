//
//  CircularCheckboxViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/6/25.
//

import Foundation

class CircularCheckboxViewModel: ObservableObject {
    @Published var habit: Habit
    @Published var isChecked: Bool = false
    private var habitManager: HabitManageInteractor
    private var currentTask: DispatchWorkItem?
    
    init(habitManager: HabitManageInteractor, habit: Habit) {
        self.habitManager = habitManager
        self.habit = habit
        setIsChecked()
    }
            
    func check() {
        if isChecked {
            Task {
                await removeCheckDay(from: habit)
                isChecked.toggle()
            }
        } else {
            Task {
                await addCheckDay(to: habit)
                isChecked.toggle()
            }
        }        
    }
    
    private func setIsChecked() {
        if habit.checkDays.contains(Date().startOfDay()) {
            isChecked = true
        }
    }
        
    private func addCheckDay(to habit: Habit) async {
        habit.addCheckDay(Date().startOfDay())
        try? await habitManager.update(habit)
    }
    
    private func removeCheckDay(from habit: Habit) async {
        await habit.removeCheckDay(Date().startOfDay())
        try? await habitManager.update(habit)
    }
}
