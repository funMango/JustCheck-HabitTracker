//
//  HabitTitleViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

class HabitTitleViewModel: ObservableObject {
    @Published var title = ""
    private var validator: HabitInputValidInteractor
    private var cancellables = Set<AnyCancellable>()
    
    init(validator: HabitInputValidInteractor) {
        self.validator = validator
        checkTitleValidity()
    }
    
    private func checkTitleValidity() {
        $title
            .sink { [weak self] newTitle in
                self?.validator.setTitle(newTitle)
            }
            .store(in: &cancellables)
    }    
}
