//
//  OverviewScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct OverviewScreen: View {
    
    @Query
    private var allTasks: [Task]
    
    @Query(filter: TaskPredicate.unfinishedPredicate, sort: Task.defaultSortDescriptors)
    private var unfinishedTasks: [Task]
    
    @Query(filter: TaskPredicate.pastDuePredicate, sort: Task.defaultSortDescriptors)
    private var pastDueTasks: [Task]
    
    @Query(filter: TaskPredicate.todayPredicate, sort: Task.defaultSortDescriptors)
    private var todayTasks: [Task]
    
    @Query(filter: TaskPredicate.tomorrowPredicate, sort: Task.defaultSortDescriptors)
    private var tomorrowTasks: [Task]
    
    @Query(filter: TaskPredicate.laterPredicate, sort: Task.defaultSortDescriptors)
    private var laterTasks: [Task]
    
    @State private var searchText = ""
    
    var body: some View {
        List {
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
        }
        .animation(.snappy, value: allTasks)
        .listStyle(.plain)
        .overlay {
            if unfinishedTasks.isEmpty {
                ContentUnavailableView("No Tasks", systemImage: "checkmark.circle")
            }
        }
        .searchable(text: $searchText) {
            SearchResultsView(searchText: searchText)
        }
    }
}

#Preview {
    OverviewScreen()
}
