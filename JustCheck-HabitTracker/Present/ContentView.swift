//
//  ContentView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

let habits : [Habit] = [
    Habit(title: "Sample1", weekDays: [Days.Mon], color: "#FF6F61"),
    Habit(title: "Sample2", weekDays: [Days.Mon, Days.Thu], color: "#191970" ),
    Habit(title: "Sample3", weekDays: [Days.Mon, Days.Fri], color: "#228B22"),
]

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text(String(localized: "today"))
                }
            
            Text("Habit")
                .tabItem {
                    Image(systemName: "flame")
                    Text(String(localized: "habit"))
                }
            
            Text("Setting")
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text(String(localized: "setting"))
                }
        }
        .tint(.tabIcon)
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
    ContentView()
}
