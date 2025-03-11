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
    
    var body: some View {
        Text(weekday)
            .frame(width: 40, height: 40)
            .background(selectedDay ? .blackGray : Color.gray.opacity(0.3))
            .foregroundColor(selectedDay ? .white : Color.gray.opacity(0.3))
            .cornerRadius(8)
    }
}

#Preview {
    @Previewable @State var selectedDay = false
    var weekday = "월"
    WeekdayButton(selectedDay: $selectedDay, weekday: weekday)
}
