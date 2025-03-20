//
//  WeekdaySelectManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/20/25.
//

import Foundation

protocol WeekdaySelectInteractor {
    func getDayOfWeeksByStatus(_ status: Bool) -> [DayOfWeek]
    func getSelectNone() -> [DayOfWeek]
}

class WeekdaySelectManager: WeekdaySelectInteractor {
    func getSelectNone() -> [DayOfWeek] {
        return [
            DayOfWeek(weekday: .Sun, status: false),
            DayOfWeek(weekday: .Mon, status: false),
            DayOfWeek(weekday: .Tue, status: false),
            DayOfWeek(weekday: .Wed, status: false),
            DayOfWeek(weekday: .Thu, status: false),
            DayOfWeek(weekday: .Fri, status: false),
            DayOfWeek(weekday: .Sat, status: false),
        ]
    }
    
    func getDayOfWeeksByStatus(_ status: Bool) -> [DayOfWeek] {
        if status {
            return getSelectAll()
        }        
        return getSelectNone()
    }
    
    func getSelectAll() -> [DayOfWeek] {
        return [
            DayOfWeek(weekday: .Sun, status: true),
            DayOfWeek(weekday: .Mon, status: true),
            DayOfWeek(weekday: .Tue, status: true),
            DayOfWeek(weekday: .Wed, status: true),
            DayOfWeek(weekday: .Thu, status: true),
            DayOfWeek(weekday: .Fri, status: true),
            DayOfWeek(weekday: .Sat, status: true),
        ]
    }
}
