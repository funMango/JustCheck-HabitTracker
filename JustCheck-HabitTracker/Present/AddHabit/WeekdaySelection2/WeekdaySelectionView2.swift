//
//  WeekdaySelectionView2.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/20/25.
//

import SwiftUI

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
                    
                    if viewModel.isAllSelected {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "circle")
                    }
                }
            }
        }
        
    }
}

struct WeekdaySelectButtonView: View {
    @EnvironmentObject var viewModel: WeekdaySelectionViewModel2
    
    var body: some View {
        HStack {
            ForEach(viewModel.weekdays, id: \.id) { day in
                Button {
                    viewModel.toggleStatus(day)                    
                } label: {
                    Text(day.weekday.localized)
                        .foregroundStyle(day.status ? .white : .gray)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(day.status ? .blackGray : .lightSiverGray)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    let dataContainer = DataContainer()
    let vmContainer = VmContainer(modelContainer: dataContainer.getModelContainer())
    
    WeekdaySelectionView2(
        viewModel:  vmContainer.getWeekdaySelectionViewModel2()
    )
}
