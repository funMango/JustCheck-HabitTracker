//
//  WeekdaySelectionViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import SwiftUI
import Combine

class WeekdaySelectionViewModel: ObservableObject {
    @Published var selectedWeekdays: [Days] = []
    private var validator: HabitInputValidInteractor
    private var manager: WeekdayManageInteractor
    private var cancellables = Set<AnyCancellable>()
        
    init(validator: HabitInputValidator, manager: WeekdayManageInteractor) {
        self.validator = validator
        self.manager = manager
        checkWeekdayValidity()
    }
    
    func updateWeekdays(from weekday: Days, status: Bool) {
        self.selectedWeekdays = manager.updateWeekdays(
            from: self.selectedWeekdays,
            target: weekday,
            status: status
        )
    }
    
    func updateAllWeekdays(from isAllSelected: Bool) {
        self.selectedWeekdays = manager.updateAllWeekDays(from: isAllSelected)
    }
            
    private func checkWeekdayValidity() {
        $selectedWeekdays
            .sink { [weak self] newWeekdays in
                self?.validator.setWeekdays(newWeekdays)
                print(newWeekdays)
            }
            .store(in: &cancellables)
    }
}
