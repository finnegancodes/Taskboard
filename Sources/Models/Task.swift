//
//  Task.swift
//  Taskboard
//
//  Created by Adam Oravec on 11/12/2023.
//

import Foundation
import SwiftData

@Model
final class Task {
    
    var content: String = ""
    var dueDate: Date = Date.today
    var creationDate: Date = Date.now
    var tags: [Tag] = []
    var isFinished: Bool = false
    
    init() {}
    
    init(from data: Task.Data) {
        self.content = data.content
        self.dueDate = data.dueDate
        self.creationDate = data.creationDate
        self.isFinished = data.isFinished
        self.tags = []
    }
    
    static let defaultSortDescriptors = [SortDescriptor(\Task.dueDate), SortDescriptor(\Task.content), SortDescriptor(\Task.creationDate)]
    
}

extension Task: Hashable {}

extension Task {
    struct Data: Codable {
        var content: String
        var dueDate: Date
        var creationDate: Date
        var isFinished: Bool
        var tags: [UUID]
        
        init(from task: Task) {
            self.content = task.content
            self.dueDate = task.dueDate
            self.creationDate = task.creationDate
            self.isFinished = task.isFinished
            self.tags = task.tags.map { $0.exportID }
        }
    }
    
    var data: Task.Data {
        Task.Data(from: self)
    }
}
