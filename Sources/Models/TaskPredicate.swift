//
//  TaskPredicate.swift
//  Taskboard
//
//  Created by Adam Oravec on 07/01/2024.
//

import Foundation
import SwiftData

struct TaskPredicate {
    
    private init() {}
    
    static var today: Date {
        Date.today
    }
    
    static var tomorrow: Date {
        Date.tomorrow
    }
    
    // MARK: --------------------------------------------------------
    
    static let unfinishedPredicate: Predicate<Task> = #Predicate { task in
        !task.isFinished
    }
    
    static let todayPredicate: Predicate<Task> = #Predicate { task in
        task.dueDate == today
    }
    
    static let tomorrowPredicate: Predicate<Task> = #Predicate { task in
        task.dueDate == tomorrow
    }
    
    static let laterPredicate: Predicate<Task> = #Predicate { task in
        task.dueDate > tomorrow
    }
    
    static let taggedPredicate: Predicate<Task> = #Predicate { task in
        !task.tags.isEmpty
    }
    
    static let finishedPredicate: Predicate<Task> = #Predicate { task in
        task.isFinished
    }
    
    static let pastDuePredicate: Predicate<Task> = #Predicate { task in
        task.dueDate < today && !task.isFinished
    }
    
    // MARK: --------------------------------------------------------
    
    static let todayUnfinishedPredicate: Predicate<Task> = #Predicate { task in
        task.dueDate == today && !task.isFinished
    }
    
    static let tomorrowUnfinishedPredicate: Predicate<Task> = #Predicate { task in
        task.dueDate == tomorrow && !task.isFinished
    }
    
    static let laterUnfinishedPredicate: Predicate<Task> = #Predicate { task in
        task.dueDate > tomorrow && !task.isFinished
    }
    
}
