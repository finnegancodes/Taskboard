//
//  Screen.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

enum Screen: Int {
    case overview
    case today
    case tomorrow
    case later
    case pastDue
    case tags
    case finished
    
    var title: LocalizedStringKey {
        switch self {
        case .overview:
            return "Overview"
        case .tags:
            return "Tags"
        case .finished:
            return "Finished"
        case .today:
            return "Today"
        case .tomorrow:
            return "Tomorrow"
        case .later:
            return "Later"
        case .pastDue:
            return "Past Due"
        }
    }
    
    var iconName: String {
        switch self {
        case .overview:
            return "checklist"
        case .tags:
            return "tag"
        case .finished:
            return "checkmark.circle"
        case .today:
            return "\(Date.today.day).square"
        case .tomorrow:
            return "\(Date.tomorrow.day).square"
        case .later:
            return "arrow.forward.square"
        case .pastDue:
            return "exclamationmark.square"
        }
    }
}
