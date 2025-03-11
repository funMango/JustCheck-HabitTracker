//
//  CircularCheckbox.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

struct CircularCheckbox: View {
    @ObservedObject private var viewModel: CircularCheckboxViewModel
    @State private var isChecked = false
    private var habit: Habit
    private var defaultSize: CGFloat = 20
    private var smallSize: CGFloat = 15
    
    init(viewModel: CircularCheckboxViewModel, habit: Habit) {
        self.viewModel = viewModel
        self.habit = habit
    }
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
            viewModel.check(habit, isChecked: isChecked)
        }) {
            ZStack {
                // 바깥 원: 체크되지 않았을 때 테두리만 회색, 체크되었을 때 테두리가 빨간색
                Circle()
                    .stroke(isChecked ? Color(hex: habit.color.hex) : Color.gray, lineWidth: 1)  // 체크된 상태에 따라 테두리 색상 변경
                    .frame(width: defaultSize, height: defaultSize)
                
                // 안쪽 원: 체크되었을 때 빨간색
                if isChecked {
                    Circle()
                        .fill(Color(hex: habit.color.hex))
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
        viewModel: vmContainer.getCheckboxViewModel(),
        habit: habit
    )
}
