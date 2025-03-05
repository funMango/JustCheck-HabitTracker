//
//  HabitRepository.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/1/25.
//

import SwiftUI
import SwiftData
import Combine

protocol HabitRepositoryProtocol {
    var event: PassthroughSubject<Void, Never> { get }
    func save(_ habit: Habit) async throws
}


class HabitRepository: HabitRepositoryProtocol {
    var event = PassthroughSubject<Void, Never>()
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
        
    @MainActor
    init(modelContainer: ModelContainer){
        self.modelContainer = modelContainer
        self.modelContext = modelContainer.mainContext
    }
    
    func save(_ habit: Habit) async throws {
        modelContext.insert(habit)
        
        do {
            try await withCheckedThrowingContinuation { continuation in
                Task {
                    do {
                        try self.modelContext.save()
                        print("💾 Habit 저장완료")
                        continuation.resume()
                    } catch {
                        print("⚠️ [Error] Habit 저장실패: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
            }
        } catch {
            print("⚠️ [Error] Habit 저장실패: \(error)")
        }
    }
}
