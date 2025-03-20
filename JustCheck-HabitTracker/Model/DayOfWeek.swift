//
//  DayOfWeek.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/17/25.
//

import Foundation

class DayOfWeek: Hashable, Equatable {
    var id = UUID().uuidString
    var weekday: Weekday
    var status: Bool
    
    init(weekday: Weekday, status: Bool) {
        self.weekday = weekday
        self.status = status
    }
    
    func toggleStatus() {
        self.status.toggle()
    }
    
    static func == (lhs: DayOfWeek, rhs: DayOfWeek) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
