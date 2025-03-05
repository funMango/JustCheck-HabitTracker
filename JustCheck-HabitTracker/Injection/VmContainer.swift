//
//  VmContainer.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import SwiftData

class VmContainer: ObservableObject {
    @Published private(set) var habitTitleViewModel: HabitTitleViewModel
    @Published private(set) var habitSaveButtonViewModel: HabitSaveButtonViewModel
    @Published private(set) var weekdaySelectionViewModel: WeekdaySelectionViewModel
    @Published private(set) var colorSelectionViewModel: ColorSelectionViewModel
    
    private let habitInputValidator = HabitInputValidator()
    private let habitManager: HabitManager
    
    @MainActor
    init(modelContainer: ModelContainer) {
        let habitRepository = HabitRepository(modelContainer: modelContainer)
        self.habitManager = HabitManager(repository: habitRepository)
        
        self.habitTitleViewModel = HabitTitleViewModel(validator: habitInputValidator, manager: habitManager)
        self.habitSaveButtonViewModel = HabitSaveButtonViewModel(
            validator: habitInputValidator,
            habitManager: habitManager
        )
        self.weekdaySelectionViewModel = WeekdaySelectionViewModel(
            validator: habitInputValidator,
            weekdayManager: WeekdayManager(),
            manager: habitManager
        )
        self.colorSelectionViewModel = ColorSelectionViewModel(
            validator: habitInputValidator,
            manager: habitManager
        )
    }
    
    func getHabitTitleViewModel() -> HabitTitleViewModel {
        return habitTitleViewModel
    }
    
    func getHabitSaveButtonViewModel() -> HabitSaveButtonViewModel {
        return habitSaveButtonViewModel
    }
    
    func getWeekdaySelectionViewModel() -> WeekdaySelectionViewModel {
        return weekdaySelectionViewModel
    }
    
    func getColorSelectioinViewModel() -> ColorSelectionViewModel {
        return colorSelectionViewModel
    }        
}
