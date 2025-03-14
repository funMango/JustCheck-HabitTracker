//
//  CircularCheckbox.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

struct CircularCheckbox: View {
    @ObservedObject private var viewModel: CircularCheckboxViewModel
    private var defaultSize: CGFloat = 20
    private var smallSize: CGFloat = 15
    
    init(viewModel: CircularCheckboxViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(action: {
            viewModel.check()
        }) {
            ZStack {
                Circle()
                    .stroke(viewModel.isChecked ? Color(hex: viewModel.habit.color.hex) : Color.gray, lineWidth: 1)
                    .frame(width: defaultSize, height: defaultSize)
                                
                if viewModel.isChecked {
                    Circle()
                        .fill(Color(hex: viewModel.habit.color.hex))
                        .frame(width: smallSize, height: smallSize)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    let dataContainer = DataContainer()
    let vmContainer = VmContainer(modelContainer: dataContainer.getModelContainer())
    let habit = Habit(title: "test", color: .orange)
    
    CircularCheckbox(
        viewModel: vmContainer.getCheckboxViewModel(habit: habit)
    )
}
