//
//  HabitColor.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import Foundation

enum HabitColor: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    
    var localized: String {
        switch self {
        case .red:
            return String(localized: "red")
        case .orange:
            return String(localized: "orange")
        case .yellow:
            return String(localized: "yellow")
        case .green:
            return String(localized: "green")
        case .blue:
            return String(localized: "blue")
        case .purple:
            return String(localized: "purple")
        }
    }
    
    var hex: String {
        switch self {
        case .red:
            return "#FF0000"
        case .orange:
            return "#FFA500"
        case .yellow:
            return "#f7f581"
        case .green:
            return "#81f789"
        case .blue:
            return "#81e5f7"
        case .purple:
            return "#8183f7"
        }
    }
}
