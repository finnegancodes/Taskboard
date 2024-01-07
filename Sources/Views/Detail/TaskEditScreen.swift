//
//  TaskEditScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

struct TaskEditScreen: View {
    
    @Bindable var task: Task
    
    var body: some View {
        TaskEditForm(taskContent: $task.content, dueDate: $task.dueDate, tags: $task.tags)
    }
}
