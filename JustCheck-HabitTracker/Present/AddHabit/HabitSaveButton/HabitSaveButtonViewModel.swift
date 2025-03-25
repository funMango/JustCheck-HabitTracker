//
//  HabitSaveButtonViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI
import Combine

class HabitSaveButtonViewModel: ObservableObject, HabitInputProtocol {
    @Published var canSave = false
    var manager: HabitManageInteractor
    var cancellables = Set<AnyCancellable>()
    
    private var validator: HabitInputValidInteractor
    private var habit: Habit?
    private var habitId: String?
    private var type: AddHabitSheetType
    
    init(validator: HabitInputValidInteractor,
         habitManager: HabitManageInteractor,
         type: AddHabitSheetType
    ) {
        self.validator = validator
        self.manager = habitManager
        self.type = type
        
        observeEvent()
        getHabitId()
    }
    
    func saveHabit() async -> Result<Void, Error> {
        do {
            if let habit = habit {
                switch self.type {
                case .add:
                    try await manager.save(habit)
                case .edit:
                    if let habitId = habitId {
                        habit.setId(habitId)
                        try await manager.update(habit)
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
    
    private func getHabitId() {
        edit { habit in
            self.habitId = habit.id
        }
    }
}
