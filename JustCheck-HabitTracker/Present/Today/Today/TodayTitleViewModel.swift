//
//  TodayTitleViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import Foundation

class TodayTitleViewModel: ObservableObject {
    @Published var title: Weekday = .Mon
    private var weekdayManager: WeekdayManageInteractor
    
    init(weekdayManager: WeekdayManageInteractor) {
        self.weekdayManager = weekdayManager
    }
    
    func updateTitle() {
        self.title = weekdayManager.getWeekday(from: Date())
    }
}
