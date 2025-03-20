//
//  HabitInputProtocol.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import Foundation
import Combine

protocol HabitInputProtocol: AnyObject {
    var manager: HabitManageInteractor { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension HabitInputProtocol {
    func reset(resetAll: @escaping () -> Void) {
        manager.resetSubject
            .receive(on: RunLoop.main)
            .sink { result in
                print("▶️ reset 시작")
                resetAll()
            }
            .store(in: &cancellables)
    }
    
    func habitInit(initialize: @escaping (_ habit: Habit) -> Void) {
        manager.habitInitSubject
            .receive(on: RunLoop.main)
            .sink { habit in
                initialize(habit)
            }
            .store(in: &cancellables)
    }
}
