//
//  TodayListView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct TodayListView: View {
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
