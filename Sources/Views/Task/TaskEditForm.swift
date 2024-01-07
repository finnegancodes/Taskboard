//
//  TaskEditForm.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct TaskEditForm: View {
    
    @Binding var taskContent: String
    @Binding var dueDate: Date
    @Binding var tags: [Tag]
    
    @Query var availableTags: [Tag]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                TextField("What needs to be done?", text: $taskContent, axis: .vertical)
                    .lineLimit(5...)
                    .padding(10)
                    .background(.secondary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                TagPicker(selection: $tags)
                    .padding(10)
                    .background(.secondary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                DueDatePicker(due: $dueDate)
            }
            .padding()
        }
    }
}
