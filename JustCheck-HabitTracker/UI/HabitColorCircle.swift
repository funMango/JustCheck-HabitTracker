//
//  HabitColorCircle.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

struct HabitColorCircle: View {
    var color: String
    private var size: CGFloat = 15
    
    init(color: String) {
        self.color = color
    }
    
    var body: some View {
        Circle()
            .fill(Color(hex: color))
            .frame(width: size, height: size)
    }
}

#Preview {
    HabitColorCircle(color: "#228B22")
}
