//
//  HabitSaveButtonViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI
import Combine

class HabitSaveButtonViewModel: ObservableObject {
    @Published var canSave = false
    private var validator: HabitInputValidInteractor
    private var cancellables = Set<AnyCancellable>()
    
    init(validator: HabitInputValidator) {
        self.validator = validator
        getEvent()
    }
    
    private func getEvent() {
        validator.subject
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.canSave = value
            }
            .store(in: &cancellables)
    }
}
