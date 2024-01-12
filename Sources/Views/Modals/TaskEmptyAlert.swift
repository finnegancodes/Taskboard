//
//  TaskEmptyAlert.swift
//  Taskboard
//
//  Created by Adam Oravec on 08/01/2024.
//

import SwiftUI

struct TaskEmptyAlert: ViewModifier {
    
    @Environment(Navigator.self) private var navigator
    
    func body(content: Content) -> some View {
        @Bindable var navigator = navigator
        content.alert("Task cannot be empty", isPresented: $navigator.showingTaskEmptyAlert) {
            
        } message: {
            Text("The task you were editing was reverted to its original content.")
        }
    }
}

extension View {
    func taskEmptyAlert() -> some View {
        modifier(TaskEmptyAlert())
    }
}
