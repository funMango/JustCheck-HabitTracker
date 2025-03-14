//
//  TodayTitleView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import SwiftUI

struct TodayTitleView: View {
    @ObservedObject var viewModel: TodayTitleViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        HStack {
            Text(viewModel.title.localizedFull)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
        }
        .onAppear {
            viewModel.updateTitle()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                viewModel.updateTitle()
            }
        }
    }
}


