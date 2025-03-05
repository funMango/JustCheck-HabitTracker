//
//  HabitSaveButtonView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct HabitSaveButtonView: View {
    @ObservedObject var viewModel: HabitSaveButtonViewModel
    @Binding var showAddHabitSheet: Bool
    
    var body: some View {
        Button {
            Task {
                let result = await viewModel.saveHabit()
                if case .success = result {
                    showAddHabitSheet.toggle()
                }
            }
        } label: {
            Text(String(localized: "save"))
                .foregroundStyle(viewModel.canSave ? .red : .gray)
        }
        .disabled(!viewModel.canSave)
    }
}
