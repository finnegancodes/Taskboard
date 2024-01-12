//
//  TaskEditScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

struct TaskEditScreen: View {
    
    @Bindable var task: Task
    
    @State private var originalContent: String
    @State private var currentContent: String
    
    @Environment(Navigator.self) private var navigator
        
    init(task: Task) {
        self.task = task
        _originalContent = State(initialValue: task.content)
        _currentContent = State(initialValue: task.content)
    }
    
    var body: some View {
        TaskEditForm(taskContent: $currentContent, dueDate: $task.dueDate, tags: $task.tags)
            .onChange(of: currentContent) { _, content in
                if content.isEmpty {
                    task.content = originalContent
                } else {
                    task.content = content
                }
            }
            .onDisappear {
                if currentContent.isEmpty {
                    navigator.showingTaskEmptyAlert = true
                }
            }
    }
}
