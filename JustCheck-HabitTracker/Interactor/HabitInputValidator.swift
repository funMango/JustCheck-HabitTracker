//
//  HabitInputValidator.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

protocol HabitInputValidInteractor {
    var subject: CurrentValueSubject<Bool, Never> { get }
    func setTitle(_ title: String)
    func setWeekdays(_ weekdays: [Days])
}

class HabitInputValidator: HabitInputValidInteractor {
    var isValid = false
    var subject = CurrentValueSubject<Bool, Never>(false)
    private var title = ""
    private var weekdays: [Days] = []
    
    func setTitle(_ title: String) {
        self.title = title
        validate()
    }
    
    func setWeekdays(_ weekdays: [Days]) {
        self.weekdays = weekdays
        validate()
    }
    
    private func validate() {
        if title.isEmpty {
            isValid = false
            subject.send(isValid)
            return
        }
        
        if weekdays.isEmpty {
            isValid = false
            subject.send(isValid)
            return
        }
                       
        isValid = true
        subject.send(isValid)
    }
}
