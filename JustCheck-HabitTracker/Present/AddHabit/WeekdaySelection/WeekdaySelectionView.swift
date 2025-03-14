//
//  WeekdaySelectionView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct WeekdaySelectionView: View {
    @ObservedObject var viewModel: WeekdaySelectionViewModel
    @State private var selectedDays: [Bool] = Array(repeating: false, count: 7)
    @State private var isAllSelected: Bool = false
    private let weekdays = Weekday.allCases
    private let height: CGFloat = 40
    
    init(viewModel: WeekdaySelectionViewModel) {
        self.viewModel = viewModel
    }
            
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Toggle(isOn: Binding(
                    get: { isAllSelected },
                    set: { newValue in
                        isAllSelected = newValue
                        selectedDays = Array(repeating: newValue, count: 7)
                        viewModel.updateAllWeekdays(from: newValue)
                    }
                )) {
                    Text(String(localized: "selectAll"))
                        .font(.system(size: 15))
                        .foregroundStyle(isAllSelected ? .blackWhite : .gray)
                }
                .toggleStyle(CheckboxToggleStyle())
            }
            .padding(.bottom, 10)            
                        
            HStack {
                ForEach(0..<7, id: \.self) { index in
                    Button(action: {
                        selectedDays[index].toggle()
                        updateAllSelectedStatus()
                        viewModel.updateWeekdays(from: weekdays[index], status: selectedDays[index])
                    }) {
                        WeekdayButton(
                            selectedDay: $selectedDays[index],
                            weekday: weekdays[index].localized
                        )                        
                    }
                }
            }
        }
        .frame(height: height)
    }
        
    private func updateAllSelectedStatus() {
        isAllSelected = selectedDays.allSatisfy { $0 }
    }
}

// MARK: - ✅ 커스텀 체크박스 스타일
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                configuration.label
                    .padding(.trailing, -3)
                                    
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(configuration.isOn ? .blackWhite : .gray)
                    
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    let dataContainer = DataContainer()
    let vmContainer = VmContainer(modelContainer: dataContainer.getModelContainer())
    
    WeekdaySelectionView(
        viewModel: vmContainer.getWeekdaySelectionViewModel()
    )
}
