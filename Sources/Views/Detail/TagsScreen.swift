//
//  TagsScreen.swift
//  Taskboard
//
//  Created by Adam Oravec on 18/12/2023.
//

import SwiftUI
import WrappingHStack
import SwiftData

struct TagsScreen: View {
    
    @Query(sort: \Tag.creationDate) 
    private var tags: [Tag]
    
    @Query(filter: #Predicate { task in
        !task.tags.isEmpty
    }, sort: Task.defaultSortDescriptors)
    private var tasks: [Task]
    
    @State private var selection: [Tag] = []
    @State private var isEditing = false
        
    var filteredTasks: [Task] {
        if selection.isEmpty {
            return tasks
        } else {
            return tasks.filter { task in
                for tag in selection {
                    let containsTag = task.tags.contains(where: { $0 == tag })
                    guard containsTag else { return false }
                }
                return true
            }
        }
    }
    
    var body: some View {
        VStack {
            if isEditing {
                VStack(alignment: .leading, spacing: 20) {
                    TagPicker(selection: .constant([]))
                    Text("Tap and hold a tag to edit.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .transition(.scale)
                .padding()
            } else {
                taskList
                    .transition(.scale)
            }
        }
        .animation(.snappy, value: isEditing)
        .toolbar {
            Button(isEditing ? "Done" : "Edit") {
                isEditing.toggle()
            }
            .fontWeight(isEditing ? .semibold : .regular)
        }
    }
    
    var taskList: some View {
        List {
            WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 8) {
                ForEach(tags) { tag in
                    let isSelected = selection.contains { $0 == tag }
                    TagChip(tag: tag, isSelected: isSelected, initialState: .normal, actionsEnabled: false, selectAction: toggle)
                }
            }
            .listRowSeparator(.hidden, edges: .all)
            TaskListerView(tasks: filteredTasks)
        }
        .listStyle(.plain)
        .overlay {
            if filteredTasks.isEmpty && !selection.isEmpty {
                ContentUnavailableView("No Tasks", systemImage: "checkmark.circle")
            }
        }
        .animation(.snappy, value: filteredTasks)
    }
    
    private func toggle(tag: Tag) {
        if let index = selection.firstIndex(of: tag) {
            selection.remove(at: index)
        } else {
            selection.append(tag)
        }
    }
}

#Preview {
    TagsScreen()
}
