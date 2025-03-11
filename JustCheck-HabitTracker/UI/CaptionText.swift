//
//  CaptionText.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 3/10/25.
//

import SwiftUI

struct CaptionText: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.caption)
                .foregroundStyle(.gray)
            
            Spacer()
        }
    }
}

#Preview {
    CaptionText(text: String(localized: "color"))
}
