//
//  FilteredTasksScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 18/12/2023.
//

import SwiftUI

struct FilteredTasksScreen: View {
    
    let tasks: [Task]
    
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
    FilteredTasksScreen(tasks: [])
}
