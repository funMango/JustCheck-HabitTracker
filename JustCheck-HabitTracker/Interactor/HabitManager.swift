//
//  HabitManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

protocol HabitManageInteractor {
    var resetSubject: PassthroughSubject<Bool, Never> { get }
    var updateSubject: PassthroughSubject<[Habit], Never> { get }
    var editSubject: PassthroughSubject<Habit, Never> { get }
    
    func save(_ habit: Habit) async throws
    func delete(_ habit: Habit) async throws
    func update(_ habit: Habit) async throws
    func editInit(_ habit: Habit)
    func sheetReset()
}

class HabitManager: HabitManageInteractor {
    var resetSubject = PassthroughSubject<Bool, Never> ()
    var updateSubject = PassthroughSubject<[Habit], Never> ()
    var editSubject = PassthroughSubject<Habit, Never> ()
    
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
    
    func editInit(_ habit: Habit) {
        editSubject.send(habit)
    }
    
    func sheetReset() {
        resetSubject.send(true)
    }
}
