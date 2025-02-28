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
    private let weekdays = Days.allCases
    
    init(viewModel: WeekdaySelectionViewModel) {
        self.viewModel = viewModel
    }
            
    var body: some View {
        VStack {
            HStack {
                Toggle(isOn: Binding(
                    get: { isAllSelected },
                    set: { newValue in
                        isAllSelected = newValue
                        selectedDays = Array(repeating: newValue, count: 7)
                        viewModel.updateAllWeekdays(from: newValue)
                    }
                )) {
                    Text(String(localized: "selectAll"))
                        .foregroundStyle(isAllSelected ? .blackWhite : .gray)
                }
                .toggleStyle(CheckboxToggleStyle())
                                
                Spacer()
            }
            .padding(.bottom, 10)
                        
            HStack {
                ForEach(0..<7, id: \.self) { index in
                    Button(action: {
                        selectedDays[index].toggle()
                        updateAllSelectedStatus()
                        viewModel.updateWeekdays(from: weekdays[index], status: selectedDays[index])
                    }) {
                        Text(weekdays[index].localized)
                            .frame(width: 40, height: 40)
                            .background(selectedDays[index] ? .blackGray : Color.gray.opacity(0.3))
                            .foregroundColor(selectedDays[index] ? .white : Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    // ✅ 전체 선택 상태 업데이트 (하나라도 해제되면 전체 선택 해제)
    private func updateAllSelectedStatus() {
        isAllSelected = selectedDays.allSatisfy { $0 } // 모든 버튼이 선택되었는지 확인
    }
}

// ✅ 커스텀 체크박스 스타일
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {                
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(configuration.isOn ? .blackWhite : .gray)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    let vmConatainer = VmContainer()
    WeekdaySelectionView(
        viewModel: vmConatainer.getWeekdaySelectionViewModel()
    )
}
