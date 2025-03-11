//
//  ContentView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vmConatiner: VmContainer
    
    init(vmContainer: VmContainer) {
        self.vmConatiner = vmContainer
    }
    
    var body: some View {
        TabView {
            HabitsView()
                .tabItem {
                    Image(systemName: "flame")
                    Text(String(localized: "habit"))
                }
            
            TodayView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text(String(localized: "today"))
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
