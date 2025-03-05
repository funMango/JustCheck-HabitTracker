//
//  ColorSelectionViewModel.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import Foundation
import Combine

class ColorSelectionViewModel: ObservableObject, HabitInputProtocol {
    @Published var selectedColor: HabitColor
    var manager: HabitManageInteractor
    var cancellables = Set<AnyCancellable>()
    private var validator: HabitInputValidInteractor
        
    init(selectedColor: HabitColor = .red ,
         validator: HabitInputValidInteractor,
         manager: HabitManageInteractor
    ) {
        self.validator = validator
        self.selectedColor = selectedColor
        self.manager = manager
        
        checkTitleValidity()
        colorReset()
    }
    
    func setSelectedColor(_ color: HabitColor) {
        self.selectedColor = color
    }
    
    private func checkTitleValidity() {
        $selectedColor
            .sink { [weak self] newColor in
                self?.validator.setSelectedColor(newColor)
            }
            .store(in: &cancellables)
    }
    
    private func colorReset() {
        reset {
            self.selectedColor = .red
        }
    }
}
