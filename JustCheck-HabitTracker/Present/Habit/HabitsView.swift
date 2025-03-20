//
//  TodayView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI
import SwiftData

struct HabitsView: View {
    @EnvironmentObject var vmContainer: VmContainer
    @State var showAddHabitSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(String(localized: "habit"))
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        showAddHabitSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.red)
                    }
                }
                .padding()
                
                HabitListView(viewModel: vmContainer.getHabitListViewModel())
                            
                Spacer()
            }
            .sheet(isPresented: $showAddHabitSheet) {
                AddHabitSheet(
                    showAddHabitSheet: $showAddHabitSheet,
                    viewModdel: vmContainer.getAddHabitSheetViewModel(habit: nil),
                    type: .add
                )
            }            
        }
        .environmentObject(vmContainer)
    }
}

#Preview {
    @Previewable @StateObject var vmContainer = VmContainer(modelContainer: DataContainer().getModelContainer())
    
    HabitsView()
        .environmentObject(vmContainer)
}
