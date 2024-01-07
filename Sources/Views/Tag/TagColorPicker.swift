//
//  TagColorPicker.swift
//  Taskboard
//
//  Created by Adam Oravec on 04/01/2024.
//

import SwiftUI
import WrappingHStack

struct TagColorPicker: View {
    
    @Bindable var tag: Tag
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            WrappingHStack(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
                ForEach(Tag.Color.allCases, id: \.rawValue) { color in
                    Circle()
                        .fill(color.rawColor)
                        .frame(width: 50, height: 50)
                        .overlay {
                            if tag.color == color {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.white.opacity(0.3))
                                    .clipShape(Circle())
                            }
                        }
                        .onTapGesture {
                            tag.color = color
                        }
                }
            }
            .padding()
            .navigationTitle("Tag Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 11, weight: .heavy))
                            .padding(7)
                            .background(.gray.opacity(0.15), in: Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
