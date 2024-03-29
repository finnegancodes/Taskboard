//
//  NewTaskSheet.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct NewTaskSheet: ViewModifier {
    
    @Environment(Navigator.self) private var navigator
        
    func body(content: Content) -> some View {
        @Bindable var navigator = navigator
        content
            .sheet(isPresented: $navigator.showingNewTaskSheet) {
                NewTaskSheetContent(openedFrom: navigator.selectedScreen)
            }
    }
}

struct NewTaskSheetContent: View {
    
    @State private var taskContent = ""
    @State private var dueDate: Date
    @State private var tagIDs: [PersistentIdentifier] = []
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var tags: [Tag]
    
    init(openedFrom screen: Screen?) {
        if screen == .tomorrow {
            _dueDate = State(initialValue: Date.tomorrow)
        } else {
            _dueDate = State(initialValue: Date.today)
        }
    }
    
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
                    .disabled(taskContent.isEmpty)
                }
            }
        }
    }
    
    private func createTask() {
        guard !taskContent.isEmpty else { return }
        
        let task = Task()
        task.content = taskContent
        task.dueDate = dueDate
        task.tags = tags.filter { tag in tagIDs.contains { $0 == tag.id } }
        modelContext.insert(task)
    }
}

extension View {
    func newTaskSheet() -> some View {
        modifier(NewTaskSheet())
    }
}
