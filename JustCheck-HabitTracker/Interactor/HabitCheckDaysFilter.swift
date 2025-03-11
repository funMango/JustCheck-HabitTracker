//
//  HabitCheckDaysFilter.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/11/25.
//

import Foundation

protocol HabitCheckDaysFilterInteractor {
    func filterCheckDaysCount(selectdDate: Date, checkDays: [Date]) -> Int
}

class HabitCheckDaysFilter: HabitCheckDaysFilterInteractor {
    let calendar: Calendar = .current
    
    func filterCheckDaysCount(selectdDate: Date, checkDays: [Date]) -> Int {
        let targetYear = calendar.component(.year, from: selectdDate)
        let targetMonth = calendar.component(.month, from: selectdDate)
        
        return checkDays.filter { day in
            let year = calendar.component(.year, from: day)
            let month = calendar.component(.month, from: day)
            return year == targetYear && month == targetMonth
        }
        .count        
    }
}

