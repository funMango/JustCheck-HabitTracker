//
//  DataContainer.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/1/25.
//

import Foundation
import SwiftData

class DataContainer {
    private var modelContainer: ModelContainer
    
    @MainActor
    init() {
        do {
            let schema = Schema([Habit.self])
            self.modelContainer = try ModelContainer(
                for: schema,
                configurations: ModelConfiguration(
                    isStoredInMemoryOnly: false,
                    cloudKitDatabase: .automatic
                )
            )
        } catch {
            fatalError("⚠️ [Error] DataContainer 시작 실패: \(error)")
        }
    }
    
    func getModelContainer() -> ModelContainer {
        return self.modelContainer
    }
}
