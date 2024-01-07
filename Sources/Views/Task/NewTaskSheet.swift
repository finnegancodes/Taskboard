//
//  NewTaskSheet.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct NewTaskSheet: ViewModifier {
    
    @Bindable var navigator: Navigator
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $navigator.showingNewTaskSheet) {
                NewTaskSheetContent()
            }
    }
}

struct NewTaskSheetContent: View {
    
    @State private var taskContent = ""
    @State private var dueDate = Date.today
    @State private var tagIDs: [PersistentIdentifier] = []
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var tags: [Tag]
    
    var body: some View {
        NavigationStack {
            TaskEditForm(taskContent: $taskContent, dueDate: $dueDate, tags: Binding {
                tags.filter { tag in tagIDs.contains { $0 == tag.id } }
            } set: {
                tagIDs = $0.map { $0.id }
            })
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        dismiss()
                        createTask()
                    }
                }
            }
        }
    }
    
    private func createTask() {
        let task = Task()
        task.content = taskContent
        task.dueDate = dueDate
        task.tags = tags.filter { tag in tagIDs.contains { $0 == tag.id } }
        modelContext.insert(task)
    }
}

extension View {
    func newTaskSheet(navigator: Navigator) -> some View {
        modifier(NewTaskSheet(navigator: navigator))
    }
}
