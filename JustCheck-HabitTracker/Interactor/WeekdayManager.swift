//
//  WeekdayManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/6/25.
//

import Foundation

protocol WeekdayManageInteractor {
    func getWeekday(from date: Date) -> Weekday
}

class WeekdayManager: WeekdayManageInteractor {
    
    func getWeekday(from date: Date) -> Weekday {
        let weekdayIndex = Calendar.current.component(.weekday, from: date)
                
        switch weekdayIndex {
        case 1:
            return .Sun
        case 2:
            return .Mon
        case 3:
            return .Tue
        case 4:
            return .Wed
        case 5:
            return .Thu
        case 6:
            return .Fri
        case 7:
            return .Sat
        default:            
            return .Mon
        }
    }
    
}
