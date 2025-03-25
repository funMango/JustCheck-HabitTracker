//
//  WeekdaySelectionViewModel2.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/22/25.
//

import Foundation
import Combine

class WeekdaySelectionViewModel2: ObservableObject, HabitInputProtocol {
    @Published var weekdays: [DayOfWeek] = []
    @Published var isAllSelected = false
    
    var manager: HabitManageInteractor
    var cancellables = Set<AnyCancellable>()
    private var selectManager: WeekdaySelectInteractor
    private var validator: HabitInputValidInteractor
    private var type: AddHabitSheetType
        
    init(
        selectManager: WeekdaySelectInteractor,
        manager: HabitManageInteractor,
        validator: HabitInputValidInteractor,
        type: AddHabitSheetType
    ) {
        self.selectManager = selectManager
        self.manager = manager
        self.validator = validator
        self.type = type
        
        setWeekdays()
        weekDayReset()
        weekDayInit()
    }
    
    func selectAll() {
        self.isAllSelected.toggle()
        self.weekdays = selectManager.getDayOfWeeksByStatus(isAllSelected)
        validator.setDayOfWeeks(weekdays)
    }
    
    func toggleStatus(_ day: DayOfWeek) {
        self.weekdays = selectManager.toggleStatus(weekdays: self.weekdays, targetDay: day)
        validator.setDayOfWeeks(weekdays)
    }
    
            
    func setWeekdays() {
        if type == .add {
            self.weekdays = selectManager.getSelectNone()
            checkWeekDays(self.weekdays)
        }
    }
    
    private func checkWeekDays(_ weekDays: [DayOfWeek]) {
        self.weekdays = weekDays
        self.isAllSelected = weekdays.allSatisfy(\.status)
        validator.setDayOfWeeks(weekdays)
    }
    
    private func weekDayReset() {
        reset { [weak self] in
            guard let self = self else { return }            
            self.weekdays = []
            self.weekdays = self.selectManager.getSelectNone()
        }
    }
    
    private func weekDayInit() {
        guard type == .edit else { return }
        edit { [weak self] habit in
            guard let self = self else { return }
            self.weekdays = []
            self.weekdays = habit.dayOfWeeks
            checkWeekDays(self.weekdays)
        }
    }
}
