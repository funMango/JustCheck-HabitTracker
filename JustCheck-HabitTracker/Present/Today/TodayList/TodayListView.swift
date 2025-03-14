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
    @Environment(\.scenePhase) private var scenePhase
    
    
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
            viewModel.fetchHabits(newHabits)
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in            
            if newPhase == .active {
                viewModel.updateWeekday()
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.habits)
    }
}


struct TodayListCellView: View {
    @EnvironmentObject var vmContainer: VmContainer
    var habit: Habit
    
    var body: some View {
        HStack {
            HabitColorCircle(color: habit.color.hex)
            
            Text(habit.title)
            
            Spacer()
            
            CircularCheckbox(
                viewModel: vmContainer.getCheckboxViewModel(habit: habit)                
            )
        }
    }
}
#Preview {
    @Previewable @StateObject var vmContainer = VmContainer(modelContainer: DataContainer().getModelContainer())
    
    let viewModel = vmContainer.getTodayListViewModel()
    
        
    TodayListView(viewModel: vmContainer.getTodayListViewModel())
        .environmentObject(vmContainer)
}
