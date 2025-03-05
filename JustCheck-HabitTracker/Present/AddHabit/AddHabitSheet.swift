//
//  AddHabitSheet.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct AddHabitSheet: View {
    @EnvironmentObject var vmContainer: VmContainer
    @Binding var showAddHabitSheet : Bool
    @FocusState var isFocused: Bool
    private var downPadding: CGFloat = 15
    private var upPadding: CGFloat = 10
    
    init(showAddHabitSheet: Binding<Bool>) {
        self._showAddHabitSheet = showAddHabitSheet
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView(isFocused: Binding(
                    get: { isFocused },
                    set: { isFocused = $0 }
                ))
                
                VStack{                                       
                    HabitTitleView(
                        viewModel: vmContainer.getHabitTitleViewModel(),
                        isFocused: $isFocused                        
                    )
                    .padding(.top, upPadding)
                    .padding(.bottom, downPadding)
                                                                                           
                    WeekdaySelectionView(
                        viewModel: vmContainer.getWeekdaySelectionViewModel()
                    )
                    .padding(.bottom, downPadding)
                                
                    Divider()
                        .padding(.bottom, downPadding)
                                       
                    ColorSelectionCellView(viewModel: vmContainer.getColorSelectioinViewModel())
                        .padding(.bottom, downPadding)
                    
                    Divider()
                        
                    Spacer()                                                    
                }
            }
            .navigationTitle(String(localized: "newHabit"))
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    HabitSaveButtonView(
                        viewModel: vmContainer.getHabitSaveButtonViewModel(),
                        showAddHabitSheet: $showAddHabitSheet
                    )
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var vmContainer = VmContainer(
        modelContainer: DataContainer().getModelContainer()
    )
    @Previewable @State var isPresented = true
    
    AddHabitSheet(showAddHabitSheet: $isPresented)
        .environmentObject(vmContainer)
}
