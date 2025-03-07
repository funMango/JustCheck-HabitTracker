//
//  Habit.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import Foundation
import SwiftData

enum HabitType: Codable {
    case test
    case normal
}

@Model
class Habit: Identifiable {
    var id = UUID().uuidString
    var createdAt: Date = Date()
    var title: String = ""
    var weekDays: [Weekday] = []
    var checkDays: [Date] = []
    var color: String = ""
    var memo: String = ""
    var type: HabitType = HabitType.normal
    
    init(title: String,
         weekDays: [Weekday] = [],
         checkDays: [Date] = [],
         color: String = HabitColor.orange.hex,
         memo: String = "",
         type: HabitType = .normal
    ) {
        self.title = title
        self.weekDays = weekDays
        self.checkDays = checkDays
        self.color = color
        self.memo = memo
        self.type = type
    }
    
    func addCheckDay(_ date: Date) {
        self.checkDays.append(date.startOfDay())
    }
    
    @MainActor
    func removeCheckDay(_ date: Date) {
        self.checkDays.removeAll { $0 == date.startOfDay() }
    }
}
