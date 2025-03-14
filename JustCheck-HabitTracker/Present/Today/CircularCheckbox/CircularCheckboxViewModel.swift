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
        Task {
            if isChecked {
                await addCheckDay(to: habit)
            } else {
                await removeCheckDay(from: habit)
            }
            await MainActor.run {
                isChecked.toggle() // ✅ 비동기 작업이 끝난 후 실행
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

