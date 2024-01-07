//
//  OverviewScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

struct OverviewScreen: View {
    
    static let today = Date.today
    static let tomorrow = Date.tomorrow
    
    let allTasks: [Task]
    let pastDueTasks: [Task]
    let todayTasks: [Task]
    let tomorrowTasks: [Task]
    let laterTasks: [Task]
    
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
            if allTasks.isEmpty {
                ContentUnavailableView("No Tasks", systemImage: "checkmark.circle")
            }
        }
        .searchable(text: $searchText) {
            SearchResultsView(searchText: searchText)
        }
    }
}

#Preview {
    OverviewScreen(allTasks: [], pastDueTasks: [], todayTasks: [], tomorrowTasks: [], laterTasks: [])
}
