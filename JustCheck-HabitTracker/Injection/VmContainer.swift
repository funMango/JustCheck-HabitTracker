//
//  VmContainer.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation

class VmContainer: ObservableObject {
    @Published private(set) var habitTitleViewModel: HabitTitleViewModel
    @Published private(set) var habitSaveButtonViewModel: HabitSaveButtonViewModel
    @Published private(set) var weekdaySelectionViewModel: WeekdaySelectionViewModel
    private let habitInputValidator = HabitInputValidator()

    init() {
        self.habitTitleViewModel = HabitTitleViewModel(validator: habitInputValidator)
        self.habitSaveButtonViewModel = HabitSaveButtonViewModel(validator: habitInputValidator)
        self.weekdaySelectionViewModel = WeekdaySelectionViewModel(
            validator: habitInputValidator,
            manager: WeekdayManager()
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
}
