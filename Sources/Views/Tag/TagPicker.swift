//
//  TagPicker.swift
//  Taskboard
//
//  Created by Adam Oravec on 17/12/2023.
//

import SwiftUI
import WrappingHStack
import SwiftData

struct TagPicker: View {
    
    @Binding var selection: [Tag]
    
    @Query(sort: \Tag.creationDate) var tags: [Tag]
    
    @State private var newTag: Tag?
    @State private var editingTag: Tag?
    
    var body: some View {
        WrappingHStack(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 8) {
            ForEach(tags) { tag in
                let isSelected = selection.contains { $0 == tag }
                TagChip(tag: tag, isSelected: isSelected, initialState: newTag == tag ? .renaming : .normal, actionsEnabled: true, selectAction: toggle) {
                    editingTag = tag
                } initialRenameAction: {
                    newTag = nil
                }
            }
            NewTagButton {
                newTag = $0
            }
        }
        .animation(.snappy, value: tags)
        .sheet(item: $editingTag) { tag in
            TagColorPicker(tag: tag)
                .presentationDetents([.medium])
        }
    }
    
    private func toggle(tag: Tag) {
        if let index = selection.firstIndex(of: tag) {
            selection.remove(at: index)
        } else {
            selection.append(tag)
        }
    }
}
