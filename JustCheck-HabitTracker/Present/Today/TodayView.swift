//
//  TodayView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/27/25.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var vmContainer: VmContainer
    @State var showAddHabitSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(String(localized: "today"))
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
                
                TodayListView()
                            
                Spacer()
            }
            .sheet(isPresented: $showAddHabitSheet) {
                AddHabitSheet(showAddHabitSheet: $showAddHabitSheet)
            }
        }
        .environmentObject(vmContainer)
    }
}

#Preview {
    TodayView()
}
