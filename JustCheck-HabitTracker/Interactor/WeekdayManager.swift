//
//  WeekdayManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import Foundation

protocol WeekdayManageInteractor {
    func updateWeekdays(from weekdays: [Days], target days: Days, status: Bool) -> [Days]
    func updateAllWeekDays(from isAllSelected: Bool) -> [Days]
}

class WeekdayManager: WeekdayManageInteractor {
    func updateWeekdays(from weekdays: [Days], target days: Days, status: Bool) -> [Days] {
        switch status {
        case true:
            return addWeekday(from: weekdays, target: days)
        case false:
            return removeWeekday(from: weekdays, target: days)
        }
    }
    
    func updateAllWeekDays(from isAllSelected: Bool) -> [Days] {
        switch isAllSelected {
        case true:
            return Days.allCases
        case false:
            return []
        }
    }
    
    private func addWeekday(from weekdays: [Days], target days: Days) -> [Days] {
        var copied = weekdays
        copied.append(days)
        return sortWeekdays(copied)
    }
    
    private func sortWeekdays(_ weekdays: [Days]) -> [Days] {
        return weekdays.sorted { (day1, day2) -> Bool in
            return day1.id < day2.id }
    }
    
    private func removeWeekday(from weekdays: [Days], target days: Days) -> [Days] {
        return weekdays.filter { $0.id != days.id }
    }
}
