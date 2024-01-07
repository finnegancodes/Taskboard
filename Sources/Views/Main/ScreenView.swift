//
//  ScreenView.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

struct ScreenView: View {
    
    let screen: Screen
        
    var body: some View {
        Group {
            switch screen {
            case .overview:
                OverviewScreen()
            case .today:
                FilteredTasksScreen(predicate: TaskPredicate.todayPredicate)
            case .tomorrow:
                FilteredTasksScreen(predicate: TaskPredicate.tomorrowPredicate)
            case .later:
                FilteredTasksScreen(predicate: TaskPredicate.laterPredicate)
            case .pastDue:
                FilteredTasksScreen(predicate: TaskPredicate.pastDuePredicate)
            case .tags:
                TagsScreen()
            case .finished:
                FilteredTasksScreen(predicate: TaskPredicate.finishedPredicate)
            }
        }
        .taskOptionsToolbar()
    }
}

#Preview {
    ScreenView(screen: .overview)
}
