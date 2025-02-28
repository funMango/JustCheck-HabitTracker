//
//  BackgroundView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var isFocused: Bool
        
    var body: some View {
        Color(.systemBackground)
            .ignoresSafeArea()
            .onTapGesture {
                isFocused = false
            }
    }
}

