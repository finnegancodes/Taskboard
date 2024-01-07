//
//  Tag.swift
//  Taskboard
//
//  Created by Adam Oravec on 11/12/2023.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Tag {
            
    var label: String = ""
    var color: Tag.Color = Tag.Color.blue
    var creationDate: Date = Date.now
    var exportID: UUID = UUID()
    @Relationship(inverse: \Task.tags) var tasks: [Task] = []
    init() {}
    
    init(label: String, color: Tag.Color) {
        self.label = label
        self.color = color
    }
    
    init(from data: Tag.Data) {
        self.label = data.label
        self.color = data.color
        self.creationDate = data.creationDate
        self.exportID = data.exportID
        self.tasks = []
    }
}

extension Tag {
    enum Color: Int, Codable, CaseIterable {
        case red, brown, orange, yellow, mint, green, teal, cyan, blue, indigo, purple, pink
        
        var rawColor: SwiftUI.Color {
            switch self {
            case .red:
                return .red
            case .brown:
                return .brown
            case .orange:
                return .orange
            case .yellow:
                return .yellow
            case .mint:
                return .mint
            case .green:
                return .green
            case .teal:
                return .teal
            case .cyan:
                return .cyan
            case .blue:
                return .blue
            case .indigo:
                return .indigo
            case .purple:
                return .purple
            case .pink:
                return .pink
            }
        }
    }
}

extension Tag {
    struct Data: Codable {
        var label: String
        var color: Tag.Color
        var creationDate: Date
        var exportID: UUID
        
        init(from tag: Tag) {
            self.label = tag.label
            self.color = tag.color
            self.creationDate = tag.creationDate
            self.exportID = tag.exportID
        }
    }
    
    var data: Tag.Data {
        Tag.Data(from: self)
    }
}
