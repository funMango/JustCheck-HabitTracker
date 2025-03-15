//
//  WeekdayButton.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/10/25.
//

import SwiftUI

struct WeekdayButton: View {
    @Binding var selectedDay: Bool
    var weekday: String
    
    init(selectedDay: Binding<Bool>, weekday: String) {
        self._selectedDay = selectedDay
        self.weekday = weekday
    }
    
    var body: some View {
        Text(weekday)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(selectedDay ? Color.blackGray : Color.gray.opacity(0.3))
            .foregroundColor(selectedDay ? .white : Color.gray.opacity(0.3))
            .cornerRadius(8)
    }
}

#Preview {
    @Previewable @State var selectedDay = true
    var weekday = "월"
    
    WeekdayButton(selectedDay: $selectedDay, weekday: weekday)
}
