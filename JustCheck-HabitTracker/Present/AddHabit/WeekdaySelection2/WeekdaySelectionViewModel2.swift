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
    private var editWeekdays: [DayOfWeek] = []
        
    init(
        selectManager: WeekdaySelectInteractor,
        manager: HabitManageInteractor,
        validator: HabitInputValidInteractor,
        editWeekdays: [DayOfWeek] = []
    ) {
        self.selectManager = selectManager
        self.manager = manager
        self.validator = validator
        self.editWeekdays = editWeekdays
        
        weekDayReset()
        setWeekdays()        
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
        if editWeekdays.isEmpty {
            self.weekdays = selectManager.getSelectNone()
        } else {
            checkWeekDays(editWeekdays)
        }
    }
    
    private func checkWeekDays(_ weekDays: [DayOfWeek]) {
        self.weekdays = weekDays
        self.isAllSelected = weekdays.allSatisfy(\.status)
        validator.setDayOfWeeks(weekdays)
    }
    
    private func weekDayReset() {
        reset {
            self.weekdays = []
        }
    }
}
