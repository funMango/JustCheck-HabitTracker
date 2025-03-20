//
//  WeekdaySelectionView2.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/20/25.
//

import SwiftUI

class WeekdaySelectionViewModel2: ObservableObject {
    @Published var weekdays: [DayOfWeek] = []
    @Published var isAllSelected = false
    private var manager: WeekdaySelectInteractor
    
    init(manager: WeekdaySelectInteractor) {
        self.manager = manager
        initialize()
    }
    
    private func initialize() {
        self.weekdays = manager.getSelectNone()
    }
    
    func selectAll() {
        self.isAllSelected.toggle()
        self.weekdays = manager.getDayOfWeeksByStatus(isAllSelected)
    }
    
    func checkWeekDays() {
        self.isAllSelected = weekdays.allSatisfy(\.status)
    }
}

struct WeekdaySelectionView2: View {
    @ObservedObject var viewModel: WeekdaySelectionViewModel2
    
    var body: some View {
        VStack {
            WeekdaySelectAllButtonView()
                        
            WeekdaySelectButtonView()
        }
        .environmentObject(viewModel)
    }
}

struct WeekdaySelectAllButtonView: View {
    @EnvironmentObject var viewModel: WeekdaySelectionViewModel2
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.selectAll()
            } label: {
                HStack {
                    Text(String(localized: "selectAll"))
                    Image(systemName: "checkmark.circle")
                }
                .foregroundStyle(viewModel.isAllSelected ? .blackWhite : .gray)
            }
        }
    }
}

struct WeekdaySelectButtonView: View {
    @EnvironmentObject var viewModel: WeekdaySelectionViewModel2
    
    var body: some View {
        HStack {
            ForEach($viewModel.weekdays, id: \.id) { $day in
                Button {
                    day.status.toggle()
                    viewModel.checkWeekDays()
                } label: {
                    Text(day.weekday.localized)
                        .foregroundStyle(day.status ? .whiteBlack : .gray)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(day.status ? .blackWhite : .lightSiver)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    var manager = WeekdaySelectManager()
    WeekdaySelectionView2(viewModel:  WeekdaySelectionViewModel2(manager: manager))
}
