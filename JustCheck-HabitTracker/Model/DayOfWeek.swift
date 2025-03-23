//
//  DayOfWeek.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/17/25.
//

import Foundation
import SwiftData

class DayOfWeek: Hashable, Equatable,Identifiable, Codable {
    var id = UUID().uuidString
    var weekday: Weekday
    var status: Bool
    
    init(
        id: String = UUID().uuidString,
        weekday: Weekday,
        status: Bool
    ) {
        self.id = id
        self.weekday = weekday
        self.status = status
    }
    
    func toggleStatus() {
        self.status.toggle()
    }
    
    func copy() -> DayOfWeek {
        let newDay = DayOfWeek(
            id: self.id,
            weekday: self.weekday,
            status: self.status
        )        
        return newDay
    }
    
    static func == (lhs: DayOfWeek, rhs: DayOfWeek) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
