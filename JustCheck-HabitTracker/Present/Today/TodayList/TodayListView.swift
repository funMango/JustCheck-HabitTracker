//
//  TodayListView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import SwiftUI
import SwiftData

struct TodayListView: View {
    @EnvironmentObject var vmContainer: VmContainer
    @ObservedObject var viewModel: TodayListViewModel
    @Query var habits: [Habit]
    
    var body: some View {
        List {
            ForEach(viewModel.habits) { habit in
                TodayListCellView(habit: habit)                    
            }
        }
        .environmentObject(vmContainer)
        .listStyle(.plain)
        .onAppear() {
            viewModel.fetchHabits(habits)
        }
        .onChange(of: habits) { oldHabits, newHabits in
            print("habits 변동 감지")
            viewModel.fetchHabits(newHabits)
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.habits)
    }
}


struct TodayListCellView: View {
    @EnvironmentObject var vmContainer: VmContainer
    var habit: Habit
    
    var body: some View {
        HStack {
            HabitColorCircle(color: habit.color)
            
            Text(habit.title)
            
            Spacer()
            
            CircularCheckbox(
                viewModel: vmContainer.getCheckboxViewModel(),
                habit: habit
            )
        }
    }
}
#Preview {
    @Previewable @StateObject var vmContainer = VmContainer(modelContainer: DataContainer().getModelContainer())
        
    TodayListView(viewModel: vmContainer.getTodayListViewModel())
        .environmentObject(vmContainer)
}
