//
//  HabitTitleViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import Foundation
import Combine

class HabitTitleViewModel: ObservableObject, HabitInputProtocol {
    @Published var title = ""
    var manager: HabitManageInteractor
    var cancellables = Set<AnyCancellable>()
    private var validator: HabitInputValidInteractor
        
    init(validator: HabitInputValidInteractor,
         manager: HabitManageInteractor
    ) {
        self.validator = validator
        self.manager = manager
        
        checkTitleValidity()
        titleReset()
    }
    
    private func checkTitleValidity() {
        $title
            .sink { [weak self] newTitle in
                self?.validator.setTitle(newTitle)
            }
            .store(in: &cancellables)
    }
    
    private func titleReset() {
        reset {
            self.title = ""
        }
    }
}
