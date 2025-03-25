//
//  WeekdaySelectionViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import SwiftUI
import Combine

class WeekdaySelectionViewModel: ObservableObject, HabitInputProtocol {
    @Published var selectedWeekdays: [Weekday] = []
    @Published var selectedDays: [Bool] = Array(repeating: false, count: 7)
    var manager: HabitManageInteractor
    var cancellables = Set<AnyCancellable>()
    private var weekdaysManager: WeekdaysManageInteractor
    private var validator: HabitInputValidInteractor
                
    init(validator: HabitInputValidator,
         weekdaysManager: WeekdaysManageInteractor,
         manager: HabitManageInteractor
    ) {
        self.validator = validator
        self.weekdaysManager = weekdaysManager
        self.manager = manager
                
        checkWeekdayValidity()
        weekdaysReset()
        weekdaysInit()
    }
    
    func updateWeekdays(from weekday: Weekday, status: Bool) {
        self.selectedWeekdays = weekdaysManager.updateWeekdays(
            from: self.selectedWeekdays,
            target: weekday,
            status: status
        )
    }
    
    func updateAllWeekdays(from isAllSelected: Bool) {
        self.selectedWeekdays = weekdaysManager.updateAllWeekDays(from: isAllSelected)
    }
    
    func updateSelectedDay(from index: Int) {
        self.selectedDays[index].toggle()
    }
            
    private func checkWeekdayValidity() {
        $selectedWeekdays
            .sink { [weak self] newWeekdays in
                self?.validator.setWeekdays(newWeekdays)
            }
            .store(in: &cancellables)
    }
        
    private func weekdaysReset() {
        reset {
            self.selectedWeekdays = []
        }
    }
    
    private func weekdaysInit() {
        edit { habit in
            self.selectedWeekdays = habit.weekDays
            self.selectedDays = habit.getselectedWeekDays()
        }
    }
}
