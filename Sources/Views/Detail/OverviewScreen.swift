//
//  OverviewScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct OverviewScreen: View {
    
    @Query(filter: TaskPredicate.pastDuePredicate, sort: Task.defaultSortDescriptors)
    private var pastDueTasks: [Task]
    
    @Query(filter: TaskPredicate.todayPredicate, sort: Task.defaultSortDescriptors)
    private var todayTasks: [Task]
    
    @Query(filter: TaskPredicate.tomorrowPredicate, sort: Task.defaultSortDescriptors)
    private var tomorrowTasks: [Task]
    
    @Query(filter: TaskPredicate.laterPredicate, sort: Task.defaultSortDescriptors)
    private var laterTasks: [Task]
    
    @Query(filter: TaskPredicate.unfinishedPredicate, sort: Task.defaultSortDescriptors)
    private var unfinishedTasks: [Task]
    
    @State private var searchText = ""
    @State private var searchResultsEmpty = false
    
    var showEmptyLabel: Bool {
        (!searchText.isEmpty && searchResultsEmpty) || (todayTasks.isEmpty && tomorrowTasks.isEmpty && laterTasks.isEmpty && unfinishedTasks.isEmpty)
    }
    
    var allTasks: [Task] {
        pastDueTasks + todayTasks + tomorrowTasks + laterTasks + unfinishedTasks
    }
    
    var body: some View {
        List {
            if searchText.isEmpty {
                if !pastDueTasks.isEmpty {
                    Section(Screen.pastDue.title) {
                        TaskListerView(tasks: pastDueTasks)
                    }
                }
                if !todayTasks.isEmpty {
                    Section(Screen.today.title) {
                        TaskListerView(tasks: todayTasks)
                    }
                }
                if !tomorrowTasks.isEmpty {
                    Section(Screen.tomorrow.title) {
                        TaskListerView(tasks: tomorrowTasks)
                    }
                }
                if !laterTasks.isEmpty {
                    Section(Screen.later.title) {
                        TaskListerView(tasks: laterTasks)
                    }
                }
            } else {
                SearchResultsView(searchText: searchText, isEmpty: $searchResultsEmpty)
            }
        }
        .listStyle(.plain)
        .overlay {
            if showEmptyLabel {
                ContentUnavailableView("No Tasks", systemImage: "checkmark.circle")
            }
        }
        .animation(.snappy, value: allTasks)
        .searchable(text: $searchText)
    }
}

#Preview {
    OverviewScreen()
}
