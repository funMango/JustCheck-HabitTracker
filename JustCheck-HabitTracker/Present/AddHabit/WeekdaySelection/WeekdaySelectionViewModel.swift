//
//  WeekdaySelectionViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import SwiftUI
import Combine

class WeekdaySelectionViewModel: ObservableObject, HabitInputProtocol {
    @Published var selectedWeekdays: [Days] = []
    var manager: HabitManageInteractor
    var cancellables = Set<AnyCancellable>()
    private var weekdayManager: WeekdayManageInteractor
    private var validator: HabitInputValidInteractor
                
    init(validator: HabitInputValidator,
         weekdayManager: WeekdayManageInteractor,
         manager: HabitManageInteractor
    ) {
        self.validator = validator
        self.weekdayManager = weekdayManager
        self.manager = manager
                
        checkWeekdayValidity()
        weekdaysReset()
    }
    
    func updateWeekdays(from weekday: Days, status: Bool) {
        self.selectedWeekdays = weekdayManager.updateWeekdays(
            from: self.selectedWeekdays,
            target: weekday,
            status: status
        )
    }
    
    func updateAllWeekdays(from isAllSelected: Bool) {
        self.selectedWeekdays = weekdayManager.updateAllWeekDays(from: isAllSelected)
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
}
