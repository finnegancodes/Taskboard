//
//  FilteredTasksScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 18/12/2023.
//

import SwiftUI
import SwiftData

struct FilteredTasksScreen: View {
    
    let predicate: Predicate<Task>
    @Query var tasks: [Task]
    
    init(predicate: Predicate<Task>) {
        self.predicate = predicate
        _tasks = Query(filter: predicate, sort: Task.defaultSortDescriptors)
    }
    
    var body: some View {
        List {
            TaskListerView(tasks: tasks)
        }
        .animation(.snappy, value: tasks)
        .listStyle(.plain)
        .overlay {
            if tasks.isEmpty {
                ContentUnavailableView("No Tasks", systemImage: "checkmark.circle")
            }
        }
    }
}

#Preview {
    let today = Date.today
    return FilteredTasksScreen(predicate: #Predicate { task in
        task.dueDate == today
    })
}
