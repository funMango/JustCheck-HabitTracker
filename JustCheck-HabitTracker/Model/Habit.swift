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
    var dayOfWeeks: [DayOfWeek] = []
    var checkDays: [Date] = []
    var memo: String = ""
    var type: HabitType = HabitType.normal
    
    private var colorRawValue: String = HabitColor.orange.rawValue
    
    var color: HabitColor {
        get { HabitColor(rawValue: colorRawValue) ?? .orange }
        set { colorRawValue = newValue.rawValue }
    }
    
    init(
        id: String = UUID().uuidString,
        createdAt: Date = Date(),
         title: String,
         weekDays: [Weekday] = [],
         dayOfWeeks: [DayOfWeek] = [],
         checkDays: [Date] = [],
         color: HabitColor = .orange,
         memo: String = "",
         type: HabitType = .normal
    ) {
        self.id = id
        self.title = title
        self.weekDays = weekDays
        self.dayOfWeeks = dayOfWeeks
        self.checkDays = checkDays
        self.colorRawValue = color.rawValue
        self.memo = memo
        self.type = type
    }
    
    func setId(_ id: String) {
        self.id = id
    }
    
    func addCheckDay(_ date: Date) {
        self.checkDays.append(date.startOfDay())
    }
    
    func getselectedWeekDays() -> [Bool] {
        let allDays: [Weekday] = [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]
        return allDays.map { weekDays.contains($0) }
    }
    
    func getCopyDayOfWeeks() -> [DayOfWeek] {
        return dayOfWeeks.map { $0.copy() }
    }
    
    @MainActor
    func removeCheckDay(_ date: Date) {
        self.checkDays.removeAll { $0 == date.startOfDay() }
    }
    
    func printSummary() {
        print("📘 Habit Summary")
        print("---------------------------")
        print("🆔 ID: \(id)")
        print("🗓️  Created At: \(createdAt.formatted(.dateTime.year().month().day().hour().minute()))")
        print("📌 Title: \(title)")
        print("🎨 Color: \(color.rawValue)")
        print("🧠 Type: \(type)")
        print("📝 Memo: \(memo)")
        
        print("📅 WeekDays: \(weekDays.map { $0.rawValue }.joined(separator: ", "))")
        
        print("🔁 DayOfWeeks:")
        for day in dayOfWeeks {
            print("   - \(day.weekday.rawValue): \(day.status ? "✅" : "❌")")
        }

        print("✔️ CheckDays:")
        for date in checkDays {
            print("   - \(date.formatted(.dateTime.year().month().day()))")
        }
        
        print("---------------------------\n")
    }
}
