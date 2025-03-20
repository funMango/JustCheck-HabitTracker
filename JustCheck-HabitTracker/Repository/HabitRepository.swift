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
    func save(_ habit: Habit) async throws
    func delete(_ habit: Habit) async throws
    func update(_ habit: Habit) async throws
    func fetch() throws -> [Habit]
}

class HabitRepository: HabitRepositoryProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
        
    @MainActor
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.modelContext = modelContainer.mainContext
    }
    
    func save(_ habit: Habit) async throws {
        modelContext.insert(habit)
        try await saveContext()
    }
    
    func delete(_ habit: Habit) async throws {
        modelContext.delete(habit)
        try await saveContext()
    }
    
    func update(_ habit: Habit) async throws {
        do {
            if let existingHabit = try fetch().first(where: { $0.id == habit.id }) {
                existingHabit.title = habit.title
                existingHabit.weekDays = habit.weekDays
                existingHabit.checkDays = habit.checkDays
                existingHabit.color = habit.color
                existingHabit.memo = habit.memo
                existingHabit.type = habit.type
                
                try await saveContext()
                print("🔄 Habit 업데이트 완료")
            } else {
                print("⚠️ [Error] Habit 업데이트 실패: 해당 Habit이 없습니다. (id: \(habit.id))")
            }
        } catch {
            print("⚠️ [Error] Habit 업데이트 실패: \(error)")
            throw error
        }
    }
    
    func fetch() throws -> [Habit]{
        do {
            let fetchRequest = FetchDescriptor<Habit>()
            let habits: [Habit] = try modelContext.fetch(fetchRequest)
            print("🔄 Habit 데이터 로딩 완료")
                        
            return habits
        } catch {
            print("⚠️ [Error] Habit 데이터 로딩 실패: \(error)")
            throw error
        }
    }
    
    private func saveContext() async throws {
        try await withCheckedThrowingContinuation { continuation in
            Task {
                do {
                    try self.modelContext.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
