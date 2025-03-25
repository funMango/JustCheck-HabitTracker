//
//  AddHabitSheet.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

enum AddHabitSheetType {
    case add
    case edit
}

struct AddHabitSheet: View {
    @EnvironmentObject var vmContainer: VmContainer
    @Binding var showAddHabitSheet : Bool
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel: AddHabitSheetViewModel
    private var type: AddHabitSheetType
    
    private var downSmallPadding: CGFloat = 10
    private var downPadding: CGFloat = 15
    private var downBigPadding: CGFloat = 30
    private var upPadding: CGFloat = 10
    
    init(showAddHabitSheet: Binding<Bool>,
         viewModdel: AddHabitSheetViewModel,
         type: AddHabitSheetType         
    ) {
        self._showAddHabitSheet = showAddHabitSheet
        self.viewModel = viewModdel
        self.type = type
        
        viewModdel.habitInit()
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
                    
                    VStack {
                        CaptionText(text: String(localized: "weekdays"))
                            .padding(.bottom, downSmallPadding)
                        
                        WeekdaySelectionView2(
                            viewModel: vmContainer.getWeekdaySelectionViewModel2(type: type)
                        )
                    }
                    .padding(.bottom, downBigPadding)
                    
                    Divider()
                        .padding(.bottom, downPadding)
                    
                    ColorSelectionCellView(
                        viewModel: vmContainer.getColorSelectioinViewModel()
                    )
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
                        viewModel: vmContainer.getHabitSaveButtonViewModel(
                            type: type
                        ),
                        showAddHabitSheet: $showAddHabitSheet
                    )
                }
            }
            .onChange(of: showAddHabitSheet) { oldValue, newValue in
                if !newValue {
                    viewModel.sheetReset()
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
    var viewModel = vmContainer.getAddHabitSheetViewModel(habit: Habit(title: "test"))
    
    AddHabitSheet(
        showAddHabitSheet: $isPresented,
        viewModdel: viewModel,
        type: .add
    )
    .environmentObject(vmContainer)
}
