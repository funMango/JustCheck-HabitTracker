//
//  AddHabitSheetViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/15/25.
//

import SwiftUI

class AddHabitSheetViewModel: ObservableObject {
    var manager: HabitManageInteractor
    var habit: Habit?
    
    init(manager: HabitManageInteractor, habit: Habit? = nil) {
        self.manager = manager
        self.habit = habit
    }
    
    func habitInit() {
        if let habit = self.habit {
            manager.editInit(habit)
        }
    }
    
    func sheetReset() {
        manager.sheetReset()
    }
}
