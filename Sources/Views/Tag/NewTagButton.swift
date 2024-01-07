//
//  NewTagButton.swift
//  Taskboard
//
//  Created by Adam Oravec on 31/12/2023.
//

import SwiftUI

struct NewTagButton: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var tagLabel = ""
    @State private var tagColor = Color.red
    
    var onCreate: ((Tag) -> Void)?
    
    var body: some View {
        Button {
            let newTag = Tag(label: "", color: .red)
            modelContext.insert(newTag)
            onCreate?(newTag)
        } label: {
            HStack {
                Image(systemName: "plus")
                    .frame(height: 15)
                Text("New Tag")
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(.secondary.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NewTagButton()
}
