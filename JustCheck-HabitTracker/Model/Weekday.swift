//
//  Weekday.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import Foundation
import SwiftData


enum Weekday: String, CaseIterable, Identifiable, Codable{
    case Sun
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    
    var localized: String {
        switch self {
        case .Sun:
            return String(localized: "sun")
        case .Mon:
            return String(localized: "mon")
        case .Tue:
            return String(localized: "tue")
        case .Wed:
            return String(localized: "wed")
        case .Thu:
            return String(localized: "thu")
        case .Fri:
            return String(localized: "fri")
        case .Sat:
            return String(localized: "sat")
        }        
    }
    
    var localizedFull: String {
        switch self {
        case .Sun:
            return String(localized: "Sun")
        case .Mon:
            return String(localized: "Mon")
        case .Tue:
            return String(localized: "Tue")
        case .Wed:
            return String(localized: "Wed")
        case .Thu:
            return String(localized: "Thu")
        case .Fri:
            return String(localized: "Fri")
        case .Sat:
            return String(localized: "Sat")        
        }
    }
        
    var id: String { self.rawValue }
}
