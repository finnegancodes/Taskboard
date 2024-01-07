//
//  TagChip.swift
//  Taskboard
//
//  Created by Adam Oravec on 18/12/2023.
//

import SwiftUI

struct TagChip: View {
    
    let tag: Tag
    let isSelected: Bool
    let initialState: InitialState
    let actionsEnabled: Bool
    var selectAction: ((Tag) -> Void)?
    var changeColorAction: (() -> Void)?
    var initialRenameAction: (() -> Void)?
    
    @State private var isRenaming: Bool = false
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack {
            if isRenaming {
                TagChipRenamingView(label: tag.label, color: tag.color.rawColor) { label in
                    isRenaming = false
                    checkLabel(label)
                    initialRenameAction?()
                }
            } else {
                Button {
                    selectAction?(tag)
                } label: {
                    HStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundStyle(isSelected ? .white : tag.color.rawColor)
                            .frame(height: 15)
                        Text("#\(tag.label)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(isSelected ? .white : .primary)
                            .lineLimit(1)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(isSelected ? tag.color.rawColor : .secondary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .animation(.snappy(duration: 0.2), value: isSelected)
                }
                .buttonStyle(.plain)
                .contextMenu {
                    if actionsEnabled {
                        contextMenu
                    }
                }
            }
        }
        .animation(.snappy, value: isRenaming)
        .onAppear {
            if initialState == .renaming {
                isRenaming = true
            }
        }
    }
    
    var contextMenu: some View {
        Group {
            Button {
                isRenaming = true
            } label: {
                Label("Rename", systemImage: "pencil")
            }
            Button {
                changeColorAction?()
            } label: {
                Label("Change Color", systemImage: "paintpalette")
            }
            Divider()
            Button(role: .destructive) {
                handleDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private func checkLabel(_ label: String) {
        if label.isEmpty {
            if initialState == .renaming {
                modelContext.delete(tag)
            }
        } else {
            tag.label = label
        }
    }
    
    private func handleDelete() {
        for task in tag.tasks {
            if let index = task.tags.firstIndex(of: tag) {
                task.tags.remove(at: index)
            }
        }
        modelContext.delete(tag)
    }
}

private struct TagChipRenamingView: View {
        
    let color: Color
    var submitAction: ((String) -> Void)?
    
    @State private var label: String
    @FocusState private var isFocused: Bool
    
    init(label: String, color: Color, submitAction: ((String) -> Void)? = nil) {
        _label = State(initialValue: label)
        self.color = color
        self.submitAction = submitAction
    }
    
    var body: some View {
        HStack {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundStyle(color)
                .frame(height: 15)
            TextField("", text: $label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.primary)
                .textFieldStyle(.plain)
                .fixedSize(horizontal: true, vertical: false)
                .focused($isFocused)
                .onSubmit {
                    submitAction?(label)
                }
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 10)
        .background(.secondary.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onAppear {
            isFocused = true
        }
        .onChange(of: isFocused) { _, isFocused in
            if !isFocused {
                submitAction?(label)
            }
        }
    }
}

extension TagChip {
    enum InitialState {
        case normal
        case renaming
    }
}
