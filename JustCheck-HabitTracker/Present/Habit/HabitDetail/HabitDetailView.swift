//
//  HabitDetailView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/7/25.
//

import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject var vmContainer: VmContainer
    @Environment(\.dismiss) var dismiss
    private var habit: Habit
    @State private var showEditHabitSheet = false
    
    init(habit: Habit) {
        self.habit = habit
    }
            
    var body: some View {
        ScrollView {
            HStack {
                Text(habit.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Divider()
                .padding()
            
            CalendarView(
                viewModel: CalendarViewModel(
                    habit: habit,
                    filter: HabitCheckDaysFilter()
                )
            )
            
            Divider()
                .padding()
            
            VStack {
                HStack {
                    CaptionText(text: String(localized: "selectedWeekdays"))
                                                            
                    Spacer()
                }
                .padding(.bottom, 10)
                                                
                HabitDetailWeekdaysView(
                    selectedDays: habit.getselectedWeekDays()                    
                )
            }
            .padding(.horizontal)
            
            Divider()
                .padding()
                                        
            VStack {
                CaptionText(text: String(localized: "color"))
                    .padding(.bottom, 10)
                
                ColorDetailView(
                    colorName: habit.color.localized,
                    colorHex: habit.color.hex,
                    size: 10
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
                                                                            
            Spacer()
        }
        .sheet(isPresented: $showEditHabitSheet) {
            AddHabitSheet(
                showAddHabitSheet: $showEditHabitSheet,
                viewModdel: vmContainer.getAddHabitSheetViewModel(habit: habit),
                type: .edit
            )
        }
        .scrollIndicators(.hidden)
        .navigationBarTitle(String(localized: "habitDetail"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showEditHabitSheet.toggle()
                } label: {
                    Text(String(localized: "edit"))
                        .foregroundStyle(.red)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.blackWhite)
                }
            }
        }
    }
}

struct HabitDetailWeekdaysView: View {
    @State private var selectedDays: [Bool]
    private let weekdays = Weekday.allCases
    
    init(selectedDays: [Bool]) {
        self.selectedDays = selectedDays
    }
    
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                WeekdayButton(
                    selectedDay: $selectedDays[index],
                    weekday: weekdays[index].localized
                )
            }
        }
        
    }
}

#Preview {
    @Previewable @StateObject var vmContainer = VmContainer(
        modelContainer: DataContainer().getModelContainer()
    )
    let habit = Habit(
        title: "Test",
        weekDays: [.Mon, .Wed]
    )
    
    HabitDetailView(habit: habit)
        .environmentObject(vmContainer)
}
