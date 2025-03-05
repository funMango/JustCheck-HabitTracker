//
//  HabitManager.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

protocol HabitManageInteractor {
    var subject: CurrentValueSubject<Bool, Never> { get }
    func save(_ habit: Habit) async throws
}

class HabitManager: HabitManageInteractor {
    var subject = CurrentValueSubject<Bool, Never> (false)
    private var repository: HabitRepositoryProtocol
        
    init(repository: HabitRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ habit: Habit) async throws {        
        do {
            try await repository.save(habit)
            subject.send(true)
        } catch {
            throw error
        }
    }
}
