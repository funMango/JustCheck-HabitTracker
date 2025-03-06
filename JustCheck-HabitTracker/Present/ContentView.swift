//
//  ContentView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

let habits : [Habit] = [
    Habit(title: "Sample1", weekDays: [Weekday.Mon], color: "#FF6F61"),
    Habit(title: "Sample2", weekDays: [Weekday.Mon, Weekday.Thu], color: "#191970"),
    Habit(title: "Sample3", weekDays: [Weekday.Mon, Weekday.Fri], color: "#228B22"),
]

struct ContentView: View {
    @ObservedObject var vmConatiner: VmContainer
    
    init(vmContainer: VmContainer) {
        self.vmConatiner = vmContainer
    }
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text(String(localized: "today"))
                }
            
            HabitsView()
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
        .tint(.blackWhite)
        .environmentObject(vmConatiner)
    }
}



#Preview {
    let dataContainer = DataContainer()
        
    ContentView(
        vmContainer: VmContainer(
            modelContainer: dataContainer.getModelContainer()
        )
    )
}
