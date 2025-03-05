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
        manager.subject
            .receive(on: RunLoop.main)
            .sink { result in
                resetAll()
            }
            .store(in: &cancellables)
    }
}
