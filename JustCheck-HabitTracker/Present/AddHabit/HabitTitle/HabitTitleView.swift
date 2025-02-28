//
//  HabitTitleView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct HabitTitleView: View {    
    @StateObject var viewModel: HabitTitleViewModel
    var isFocused: FocusState<Bool>.Binding
    @State private var title: String = ""
    
    var body: some View {
        VStack {
            TextField(String(localized: "title"), text: $viewModel.title)
                .focused(isFocused)
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
               
            Divider()
        }
    }
}

#Preview {
    let vmConatainer = VmContainer()
    
    @FocusState var isFocused: Bool
    HabitTitleView(
        viewModel: vmConatainer.getHabitTitleViewModel(),
        isFocused: $isFocused
    )
}
