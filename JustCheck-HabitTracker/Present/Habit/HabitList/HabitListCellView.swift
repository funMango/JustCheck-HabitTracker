//
//  HabitListCellView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import SwiftUI

struct HabitListCellView: View {
    var habit: Habit
    
    var body: some View {
        HStack {
            HabitColorCircle(color: habit.color)
            
            Text(habit.title)
            
            Spacer()
        }
    }
}

#Preview {
    let habit = Habit(title: "sample1")    
    HabitListCellView(habit: habit)
}
