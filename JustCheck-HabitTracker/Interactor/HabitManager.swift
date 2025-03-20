//
//  HabitManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

protocol HabitManageInteractor {
    var resetSubject: CurrentValueSubject<Bool, Never> { get }
    var updateSubject: PassthroughSubject<[Habit], Never> { get }
    var habitInitSubject: PassthroughSubject<Habit, Never> { get }
    func save(_ habit: Habit) async throws
    func delete(_ habit: Habit) async throws
    func update(_ habit: Habit) async throws
    func habitInit(_ habit: Habit)
    func sheetReset()
}

class HabitManager: HabitManageInteractor {
    var resetSubject = CurrentValueSubject<Bool, Never> (false)
    var updateSubject = PassthroughSubject<[Habit], Never> ()
    var habitInitSubject = PassthroughSubject<Habit, Never> ()
    
    private var repository: HabitRepositoryProtocol
        
    init(repository: HabitRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ habit: Habit) async throws {        
        do {
            try await repository.save(habit)
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
            try await repository.update(habit)
            let habits = try repository.fetch()
            updateSubject.send(habits)
        } catch {
            throw error
        }
    }
    
    func habitInit(_ habit: Habit) {
        habitInitSubject.send(habit)
    }
    
    func sheetReset() {
        resetSubject.send(true)
    }
}
