//
//  TodayView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/5/25.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var vmContainer: VmContainer
    
    var body: some View {
        VStack {            
            TodayTitleView(
                viewModel: vmContainer.getTodayTitleViewModel()
            )
            .padding()
            
            
            TodayListView(
                viewModel: vmContainer.getTodayListViewModel()
            )
                                    
            Spacer()
        }
    }
}

#Preview {
    @Previewable @StateObject var vmContainer = VmContainer(modelContainer: DataContainer().getModelContainer())
    
    TodayView()
        .environmentObject(vmContainer)
}
