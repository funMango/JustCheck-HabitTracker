//
//  CircularCheckbox.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import SwiftUI

struct CircularCheckbox: View {
    @State private var isChecked: Bool = false
    var color: String
    private var size: CGFloat = 20
    private var size2: CGFloat = 15
    
    init(color: String) {
        self.color = color
    }
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            ZStack {
                // 바깥 원: 체크되지 않았을 때 테두리만 회색, 체크되었을 때 테두리가 빨간색
                Circle()
                    .stroke(isChecked ? Color(hex: color) : Color.gray, lineWidth: 1)  // 체크된 상태에 따라 테두리 색상 변경
                    .frame(width: size, height: size)
                
                // 안쪽 원: 체크되었을 때 빨간색
                if isChecked {
                    Circle()
                        .fill(Color(hex: color))
                        .frame(width: size2, height: size2)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CircularCheckbox(color: "#228B22")
}
