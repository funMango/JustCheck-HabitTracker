//
//  HabitInputValidator.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

protocol HabitInputValidInteractor {
    var subject: CurrentValueSubject<Habit?, Never> { get set }
    func setTitle(_ title: String)
    func setWeekdays(_ weekdays: [Weekday])
    func setDayOfWeeks(_ dayOfWeeks: [DayOfWeek])
    func setSelectedColor(_ color: HabitColor)
}

class HabitInputValidator: HabitInputValidInteractor {    
    var subject = CurrentValueSubject<Habit?, Never>(nil)
    private var title = ""
    private var weekdays: [Weekday] = []
    private var selectedColor: HabitColor = .red
    private var dayOfweeks: [DayOfWeek] = []
    
    func setTitle(_ title: String) {
        self.title = title
        validate()
    }
    
    func setWeekdays(_ weekdays: [Weekday]) {
        self.weekdays = weekdays
        validate()
    }
    
    func setSelectedColor(_ color: HabitColor) {
        self.selectedColor = color
        validate()
    }
    
    func setDayOfWeeks(_ dayOfWeeks: [DayOfWeek]) {
        self.dayOfweeks = dayOfWeeks
        validate()
    }
    
    private func validate() {
        if title.isEmpty {
            subject.send(nil)
            return
        }
        
//        if weekdays.isEmpty {
//            subject.send(nil)
//            return
//        }
        
        if !validDayOfWeeks() {
            subject.send(nil)
            return
        }
        
        let habit = Habit(
            title: title,
            dayOfWeeks: dayOfweeks,
            color: selectedColor
        )
        
        subject.send(habit)
    }
    
    private func validDayOfWeeks() -> Bool {
        let filtered = dayOfweeks.filter { $0.status == true }
        return !filtered.isEmpty
    }
}
