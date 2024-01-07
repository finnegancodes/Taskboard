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
    var selectedScreen: Screen?
    var selectedTask: Task? = nil
    var showingNewTaskSheet = false
    var showingSettingsScreen = false
}
