//
//  TaskboardApp.swift
//  Taskboard
//
//  Created by Adam Oravec on 09/09/2023.
//

import SwiftUI

typealias AsyncTask = SwiftUI.Task

@main
struct TaskboardApp: App {
    
    @State private var navigator = Navigator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navigator)
        }
        .modelContainer(for: Task.self)
    }
}
