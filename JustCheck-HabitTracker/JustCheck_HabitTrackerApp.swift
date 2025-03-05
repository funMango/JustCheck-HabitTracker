//
//  JustCheck_HabitTrackerApp.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI
import SwiftData

@main
struct JustCheck_HabitTrackerApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                vmContainer: VmContainer(
                    modelContainer: dataContainer.getModelContainer()
                )
            )
            .environment(\.modelContext, dataContainer.getModelContainer().mainContext)
        }
    }
}
