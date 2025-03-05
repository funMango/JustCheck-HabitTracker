//
//  TodayListView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI
import SwiftData

struct TodayListView: View {
    @Query var habits: [Habit]
    
    var body: some View {
        List {
            ForEach(habits) { habit in
                TodayListCellView(habit: habit)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    TodayListView()
}
