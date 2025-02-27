//
//  AddHabitSheet.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct AddHabitSheet: View {
    @Binding var showAddHabitSheet : Bool
    @State var title = ""
    private var downPadding: CGFloat = 30
    private var upPadding: CGFloat = 10
    
    init(showAddHabitSheet: Binding<Bool>) {
        self._showAddHabitSheet = showAddHabitSheet
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField(String(localized: "title"), text: $title)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                    .padding(.top, upPadding)
                
                Divider()
                    .padding(.bottom, downPadding)
                                                                                       
                WeekdaySelectionView()
                    .padding(.bottom, downPadding)
                            
                Divider()
                    .padding(.bottom, downPadding)
                
                
                    
                Spacer()
                            
                
            }
            .navigationTitle("새로운 습관")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("저장")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isPresented = true
    return AddHabitSheet(showAddHabitSheet: $isPresented)
}
