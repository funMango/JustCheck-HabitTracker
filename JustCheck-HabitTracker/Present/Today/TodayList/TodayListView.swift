//
//  TodayListView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import SwiftUI
import SwiftData

struct TodayListView: View {
    @ObservedObject var viewModel: TodayListViewModel
    @Query var habits: [Habit]
    
    var body: some View {
        List {
            ForEach(viewModel.habits) { habit in
                TodayListCellView(habit: habit)
            }
        }
        .listStyle(.plain)
        .onAppear() {
            viewModel.fetchHabits(habits)
        }
        .onChange(of: habits) { oldHabits, newHabits in
            viewModel.fetchHabits(newHabits)
        }
    }
}


struct TodayListCellView: View {
    var habit: Habit
    
    var body: some View {
        HStack {
            HabitColorCircle(color: habit.color)
            
            Text(habit.title)
            
            Spacer()
            
            CircularCheckbox(color: habit.color)
        }
    }
}
#Preview {
    let dataContainer = DataContainer()
    let vmContainer = VmContainer(modelContainer: dataContainer.getModelContainer())
    
    TodayListView(viewModel: vmContainer.getTodayListViewModel())
}
