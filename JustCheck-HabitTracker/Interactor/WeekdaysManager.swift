//
//  WeekdaysManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import Foundation

protocol WeekdaysManageInteractor {
    func updateWeekdays(from weekdays: [Weekday], target days: Weekday, status: Bool) -> [Weekday]
    func updateAllWeekDays(from isAllSelected: Bool) -> [Weekday]
}

class WeekdaysManager: WeekdaysManageInteractor {
    func updateWeekdays(from weekdays: [Weekday], target days: Weekday, status: Bool) -> [Weekday] {
        switch status {
        case true:
            return addWeekday(from: weekdays, target: days)
        case false:
            return removeWeekday(from: weekdays, target: days)
        }
    }
    
    func updateAllWeekDays(from isAllSelected: Bool) -> [Weekday] {
        switch isAllSelected {
        case true:
            return Weekday.allCases
        case false:
            return []
        }
    }
    
    private func addWeekday(from weekdays: [Weekday], target weekday: Weekday) -> [Weekday] {
        var copied = weekdays
        copied.append(weekday)
        return sortWeekdays(copied)
    }
    
    private func sortWeekdays(_ weekdays: [Weekday]) -> [Weekday] {
        return weekdays.sorted { (day1, day2) -> Bool in
            return day1.id < day2.id }
    }
    
    private func removeWeekday(from weekdays: [Weekday], target days: Weekday) -> [Weekday] {
        return weekdays.filter { $0.id != days.id }
    }
}
