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
    
    init(validator: HabitInputValidInteractor,
         habitManager: HabitManageInteractor
    ) {
        self.validator = validator
        self.habitManager = habitManager
        observeEvent()
    }
    
    func saveHabit() async -> Result<Void, Error> {
        do {
            if let habit = habit {
                try await habitManager.save(habit)
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
