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
    @Published private(set) var weekdaySelectionViewModel: WeekdaySelectionViewModel
    @Published private(set) var colorSelectionViewModel: ColorSelectionViewModel
    @Published private(set) var habitListViewModel: HabitListViewModel
    @Published private(set) var todayListViewModel: TodayListViewModel
    @Published private(set) var todayTitleViewModel: TodayTitleViewModel
                
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
    }
    
    func getHabitTitleViewModel() -> HabitTitleViewModel {
        return habitTitleViewModel
    }
    
    func getHabitSaveButtonViewModel(type: AddHabitSheetType, oldHabit: Habit? = nil) -> HabitSaveButtonViewModel {
        return HabitSaveButtonViewModel(
            validator: habitInputValidator,
            habitManager: habitManager,
            type: type,
            oldHabit: oldHabit
        )
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
    
    func getCheckboxViewModel(habit: Habit) -> CircularCheckboxViewModel {
        return CircularCheckboxViewModel(
            habitManager: self.habitManager,
            habit: habit
        )
    }
    
    func getAddHabitSheetViewModel(habit: Habit?) -> AddHabitSheetViewModel {
        return AddHabitSheetViewModel(
            manager: habitManager,
            habit: habit
        )
    }
    
    func getWeekdaySelectionViewModel2(editWeekdays: [DayOfWeek] = []) -> WeekdaySelectionViewModel2 {
        return WeekdaySelectionViewModel2(
            selectManager: WeekdaySelectManager(),
            manager: habitManager,
            validator: habitInputValidator,            
            editWeekdays: editWeekdays
        )
    }
}
