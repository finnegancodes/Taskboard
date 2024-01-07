//
//  TaskView.swift
//  Taskboard
//
//  Created by Adam Oravec on 14/12/2023.
//

import SwiftUI
import WrappingHStack

struct TaskView: View {
    
    let task: Task
    
    @Environment(\.modelContext) var modelContext
    
    var isPastDue: Bool {
        task.dueDate < Date.today && !task.isFinished
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                task.isFinished.toggle()
            } label: {
                if task.isFinished {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.accent)
                } else {
                    Image(systemName: "circle")
                        .foregroundStyle(.secondary)
                }
            }
            .font(.system(size: 22, weight: .medium))
            .buttonStyle(.plain)
            VStack(alignment: .leading, spacing: 3) {
                Text(task.content)
                    .font(.headline)
                    .lineLimit(2)
                    .strikethrough(task.isFinished)
                    .foregroundStyle(task.isFinished ? .secondary : .primary)
                HStack(alignment: .top) {
                    Text(task.dueDate.formatted(date: .numeric, time: .omitted))
                        .foregroundStyle(isPastDue ? Color.red : Color.secondary)
                        .fontWeight(isPastDue ? Font.Weight.medium : Font.Weight.regular)
                        .lineLimit(1)
                    WrappingHStack(alignment: .leading) {
                        ForEach(task.tags) { tag in
                            Text("#\(tag.label)")
                                .foregroundStyle(tag.color.rawColor)
                                .lineLimit(1)
                        }
                    }
                }
                .font(.subheadline)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                modelContext.delete(task)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .sensoryFeedback(.impact, trigger: task.isFinished)
    }
}
