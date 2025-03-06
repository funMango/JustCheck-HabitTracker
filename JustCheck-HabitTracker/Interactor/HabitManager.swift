//
//  HabitManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

protocol HabitManageInteractor {
    var saveSubject: CurrentValueSubject<Bool, Never> { get }
    var updateSubject: CurrentValueSubject<[Habit], Never> { get }
    func save(_ habit: Habit) async throws
    func delete(_ habit: Habit) async throws
    func update(_ habit: Habit) async throws
}

class HabitManager: HabitManageInteractor {
    var saveSubject = CurrentValueSubject<Bool, Never> (false)
    var updateSubject = CurrentValueSubject<[Habit], Never> ([])
    
    private var repository: HabitRepositoryProtocol
        
    init(repository: HabitRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ habit: Habit) async throws {        
        do {
            try await repository.save(habit)
            saveSubject.send(true)
        } catch {
            throw error
        }
    }
    
    func delete(_ habit: Habit) async throws {
        do {
            try await repository.delete(habit)
        } catch {
            throw error
        }
    }
    
    func update(_ habit: Habit) async throws {
        do {
            try await repository.save(habit)
            let habits = try repository.fetch()
            updateSubject.send(habits)
        } catch {
            throw error
        }
    }
}
