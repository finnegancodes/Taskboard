//
//  NewTaskButton.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct NewTaskButton: ViewModifier {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(Navigator.self) private var navigator: Navigator
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        createNewTask()
                    } label: {
                        Label("New Task", systemImage: "plus")
                            .labelStyle(.titleAndIcon)
                    }
                    .buttonStyle(.borderless)
                    .fontWeight(.medium)
                    Spacer()
                }
            }
    }
    
    private func createNewTask() {
        navigator.showingNewTaskSheet = true
    }
}

extension View {
    func newTaskButton() -> some View {
        modifier(NewTaskButton())
    }
}
