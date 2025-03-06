//
//  TodayListView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI
import SwiftData

struct HabitListView: View {
    @ObservedObject var viewModel: HabitListViewModel
    @Query var habits: [Habit]
    
    var body: some View {
        List {
            ForEach(viewModel.habits) { habit in
                HabitListCellView(habit: habit)
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteHabit(habit)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                    .animation(.easeInOut(duration: 0.5), value: habit)
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

#Preview {
    let dataContainer = DataContainer()
    let vmContainer = VmContainer(modelContainer: dataContainer.getModelContainer())
    
    HabitListView(viewModel: vmContainer.getHabitListViewModel())
}
