//
//  HabitColorCircle.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

struct HabitColorCircle: View {
    var color: String
    private var size: CGFloat
    
    init(color: String, size: CGFloat = 15) {
        self.color = color
        self.size = size
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
