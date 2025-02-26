//
//  Habit.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import Foundation

class Habit: Identifiable {
    var id = UUID().uuidString
    var title: String = ""
    var weekDays: [Days] = []
    var color: String = ""
    
    init(title: String, weekDays: [Days] = [], color: String = HabitColor.Orange.rawValue) {
        self.title = title
        self.weekDays = weekDays
        self.color = color
    }
}
