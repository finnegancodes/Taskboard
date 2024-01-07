//
//  TaskOptionsToolbar.swift
//  Taskboard
//
//  Created by Adam Oravec on 05/01/2024.
//

import SwiftUI
import SwiftData

struct TaskOptionsToolbar: ViewModifier {
    
    static let today = Date.today
    
    @Query(filter: TaskPredicate.finishedPredicate)
    var finishedTasks: [Task]
    
    @Environment(\.modelContext) private var modelContext
    @State private var showingDeleteFinishedConfirmation = false
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    toolbarContent
                }
            }
    }
    
    var toolbarContent: some View {
        Menu {
            Button(role: .destructive) {
                showingDeleteFinishedConfirmation = true
            } label: {
                Label("Delete Finished", systemImage: "trash")
            }
        } label: {
            Label("Options", systemImage: "ellipsis.circle")
        }
        .alert("Delete Finished?", isPresented: $showingDeleteFinishedConfirmation) {
            Button("Delete", role: .destructive, action: deleteFinishedTasks)
        } message: {
            Text("All tasks marked as finished will be permanently deleted.")
        }
    }
    
    private func deleteFinishedTasks() {
        for task in finishedTasks {
            modelContext.delete(task)
        }
    }
}

extension View {
    func taskOptionsToolbar() -> some View {
        modifier(TaskOptionsToolbar())
    }
}
