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
class Habit: Equatable, Identifiable {
    var id = UUID().uuidString
    var createdAt: Date = Date()
    var title: String = ""
    var weekDays: [Weekday] = []
    var checkDays: [Date] = []
    var memo: String = ""
    var type: HabitType = HabitType.normal
    
    private var colorRawValue: String = HabitColor.orange.rawValue
    
    var color: HabitColor {
        get { HabitColor(rawValue: colorRawValue) ?? .orange }
        set { colorRawValue = newValue.rawValue }
    }
    
    init(title: String,
         weekDays: [Weekday] = [],
         checkDays: [Date] = [],
         color: HabitColor = .orange,
         memo: String = "",
         type: HabitType = .normal
    ) {
        self.title = title
        self.weekDays = weekDays
        self.checkDays = checkDays
        self.colorRawValue = color.rawValue
        self.memo = memo
        self.type = type
    }
    
    func addCheckDay(_ date: Date) {
        self.checkDays.append(date.startOfDay())
    }
    
    func getselectedWeekDays() -> [Bool] {
        let allDays: [Weekday] = [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]
        return allDays.map { weekDays.contains($0) }
    }
    
    @MainActor
    func removeCheckDay(_ date: Date) {
        self.checkDays.removeAll { $0 == date.startOfDay() }
    }
}
