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
                    Image(systemName: "house")
                    Text("Today")
                }
            
            Text("Habit")
                .tabItem {
                    Image(systemName: "house")
                    Text("Habit")
                }
            
            Text("Setting")
                .tabItem {
                    Image(systemName: "house")
                    Text("Setting")
                }
        }
    }
}

struct TodayView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Today")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.red)
                }
            }
            .padding()
            
            List {
                ForEach(habits) { habit in
                    TodayListCellView(habit: habit)
                }
            }
            .listStyle(.plain)
            
            
            Spacer()
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
    ContentView()
}
