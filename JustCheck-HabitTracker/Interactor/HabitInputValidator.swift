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
    func setWeekdays(_ weekdays: [Days])
    func setSelectedColor(_ color: HabitColor)
}

class HabitInputValidator: HabitInputValidInteractor {    
    var subject = CurrentValueSubject<Habit?, Never>(nil)
    private var title = ""
    private var weekdays: [Days] = []
    private var selectedColor: HabitColor = .red
    
    func setTitle(_ title: String) {
        self.title = title
        validate()
    }
    
    func setWeekdays(_ weekdays: [Days]) {
        self.weekdays = weekdays
        validate()
    }
    
    func setSelectedColor(_ color: HabitColor) {
        self.selectedColor = color
        validate()
    }
    
    private func validate() {
        if title.isEmpty {
            subject.send(nil)
            return
        }
        
        if weekdays.isEmpty {
            subject.send(nil)
            return
        }
        
        let habit = Habit(
            title: title,
            weekDays: weekdays,
            color: selectedColor.hex
        )
        
        subject.send(habit)
    }
    
    func sendInitializationSignal() {
        
    }
}
