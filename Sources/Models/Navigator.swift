//
//  Navigator.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import Foundation
import Observation

@Observable
final class Navigator {
    
    var path: [Task] = []
    var selectedScreen: Screen?
    var showingNewTaskSheet = false
    var showingSettingsScreen = false
    var showingTaskEmptyAlert = false
    
    func push(task: Task) {
        if selectedScreen == nil {
            selectedScreen = .overview
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.path.append(task)
            }
        } else {
            path.append(task)
        }
    }
    
    func pop() {
        if path.count > 0 {
            path.removeLast()
        }
    }
}

