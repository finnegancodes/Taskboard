//
//  ScreenView.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct ScreenView: View {
    
    let screen: Screen
    
    static let today = Date.today
    static let tomorrow = Date.tomorrow
    
    @Query(filter: #Predicate { task in
        !task.isFinished
    }, sort: Task.defaultSortDescriptors)
    var allTasks: [Task]
    
    @Query(filter: #Predicate { task in
        task.dueDate < today && !task.isFinished
    }, sort: Task.defaultSortDescriptors)
    var pastDueTasks: [Task]
    
    @Query(filter: #Predicate { task in
        task.dueDate == today
    }, sort: Task.defaultSortDescriptors)
    var todayTasks: [Task]
    
    @Query(filter: #Predicate { task in
        task.dueDate == tomorrow
    }, sort: Task.defaultSortDescriptors)
    var tomorrowTasks: [Task]
    
    @Query(filter: #Predicate { task in
        task.dueDate > tomorrow
    }, sort: Task.defaultSortDescriptors)
    var laterTasks: [Task]
    
    @Query(filter: #Predicate { task in
        !task.tags.isEmpty
    }, sort: Task.defaultSortDescriptors)
    var taggedTasks: [Task]
    
    @Query(filter: #Predicate { task in
        task.isFinished
    }, sort: Task.defaultSortDescriptors)
    var finishedTasks: [Task]
        
    var body: some View {
        Group {
            switch screen {
            case .overview:
                OverviewScreen(allTasks: allTasks, pastDueTasks: pastDueTasks, todayTasks: todayTasks, tomorrowTasks: tomorrowTasks, laterTasks: laterTasks)
            case .today:
                FilteredTasksScreen(tasks: todayTasks)
            case .tomorrow:
                FilteredTasksScreen(tasks: tomorrowTasks)
            case .later:
                FilteredTasksScreen(tasks: laterTasks)
            case .pastDue:
                FilteredTasksScreen(tasks: pastDueTasks)
            case .tags:
                TagsScreen(tasks: taggedTasks)
            case .finished:
                FilteredTasksScreen(tasks: finishedTasks)
            }
        }
        .taskOptionsToolbar(finishedTasks: finishedTasks)
    }
}

#Preview {
    ScreenView(screen: .overview)
}
