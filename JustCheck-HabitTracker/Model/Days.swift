//
//  Days.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/26/25.
//

import Foundation

enum Days: String, CaseIterable, Identifiable{
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    case Sun
    
    var id: String { self.rawValue }
}
