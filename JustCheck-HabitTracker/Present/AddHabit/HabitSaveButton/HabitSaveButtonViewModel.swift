//
//  HabitSaveButtonViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI
import Combine

class HabitSaveButtonViewModel: ObservableObject {
    @Published var canSave = false
    private var validator: HabitInputValidInteractor
    private var habitManager: HabitManageInteractor
    private var cancellables = Set<AnyCancellable>()
    private var habit: Habit?
    private var oldHabit: Habit?
    private var type: AddHabitSheetType
    
    init(validator: HabitInputValidInteractor,
         habitManager: HabitManageInteractor,
         type: AddHabitSheetType,
         oldHabit: Habit? = nil
    ) {
        self.validator = validator
        self.habitManager = habitManager
        self.type = type
        self.oldHabit = oldHabit
        observeEvent()
    }
    
    func saveHabit() async -> Result<Void, Error> {
        do {
            if let habit = habit {
                switch self.type {
                case .add:
                    try await habitManager.save(habit)
                case .edit:
                    if let oldHabit = oldHabit {
                        habit.id = oldHabit.id
                        try await habitManager.update(habit)
                    }
                }                
                return Result.success(())
            }
            return .failure(NSError(domain: "HabitError", code: 1, userInfo: nil))
        } catch {
            return Result.failure((error))
        }        
    }
    
    private func observeEvent() {
        validator.subject
            .receive(on: RunLoop.main)
            .sink { [weak self] habit in
                withAnimation(.easeInOut(duration: 0.5)){
                    self?.canSave = habit != nil
                }
                self?.habit = habit
            }
            .store(in: &cancellables)
    }
}
