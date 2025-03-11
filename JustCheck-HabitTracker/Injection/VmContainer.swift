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
    @Published private(set) var habitListViewModel: HabitListViewModel
    @Published private(set) var todayListViewModel: TodayListViewModel
    @Published private(set) var todayTitleViewModel: TodayTitleViewModel
    @Published private(set) var circularCheckboxViewModel: CircularCheckboxViewModel    
        
    private let habitInputValidator = HabitInputValidator()
    private let habitManager: HabitManager
    
    @MainActor
    init(modelContainer: ModelContainer) {
        let habitRepository = HabitRepository(modelContainer: modelContainer)
        self.habitManager = HabitManager(repository: habitRepository)
        
        self.habitTitleViewModel = HabitTitleViewModel(
            validator: habitInputValidator,
            manager: habitManager
        )
        
        self.habitSaveButtonViewModel = HabitSaveButtonViewModel(
            validator: habitInputValidator,
            habitManager: habitManager
        )
        
        self.weekdaySelectionViewModel = WeekdaySelectionViewModel(
            validator: habitInputValidator,
            weekdaysManager: WeekdaysManager(),
            manager: habitManager
        )
        
        self.colorSelectionViewModel = ColorSelectionViewModel(
            validator: habitInputValidator,
            manager: habitManager
        )
        
        self.habitListViewModel = HabitListViewModel(
            manager: habitManager
        )
        
        self.todayListViewModel = TodayListViewModel(
            habitManager: habitManager,
            weekdayManager: WeekdayManager(),
            habitFilter: HabitFilter()
        )
        
        self.todayTitleViewModel = TodayTitleViewModel(
            weekdayManager: WeekdayManager()
        )
        
        self.circularCheckboxViewModel = CircularCheckboxViewModel(
            habitManager: habitManager
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
    
    func getHabitListViewModel() -> HabitListViewModel {
        return habitListViewModel
    }
    
    func getTodayListViewModel() -> TodayListViewModel {
        return todayListViewModel
    }
    
    func getTodayTitleViewModel() -> TodayTitleViewModel {
        return todayTitleViewModel
    }
    
    func getCheckboxViewModel() -> CircularCheckboxViewModel {
        return circularCheckboxViewModel
    }    
}
