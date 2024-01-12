//
//  ContentView.swift
//  Taskboard
//
//  Created by Adam Oravec on 11/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(Navigator.self) var navigator: Navigator
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("remindersEnabled") var remindersEnabled: Bool = false
    
    @Query(filter: #Predicate { task in
        !task.isFinished
    }, sort: Task.defaultSortDescriptors)
    var allTasks: [Task]
    
    var body: some View {
        @Bindable var navigator = self.navigator
        NavigationSplitView {
            ScreenList(navigator: navigator)
                .navigationTitle("Taskboard")
                .screenListToolbar()
        } detail: {
            NavigationStack(path: $navigator.path) {
                if let screen = navigator.selectedScreen {
                    ScreenView(screen: screen)
                        .navigationTitle(screen.title)
                        .navigationBarTitleDisplayMode(.large)
                        .navigationDestination(for: Task.self) { task in
                            TaskEditScreen(task: task)
                                .navigationTitle("Edit Task")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                } else {
                    Text("Select Category")
                        .navigationBarTitleDisplayMode(.large)
                }
            }
        }
        .newTaskButton()
        .newTaskSheet()
        .settingsSheet()
        .taskEmptyAlert()
        .task(checkNotificationPermission)
        .onChange(of: scenePhase) { _, scenePhase in
            if scenePhase == .background {
                handleSceneChange()
            }
        }
    }
    
    @Sendable func checkNotificationPermission() async {
        let status = await UNUserNotificationCenter.getAuthorizationStatus()
        if status != .authorized {
            remindersEnabled = false
        }
    }
    
    func handleSceneChange() {
        guard remindersEnabled else { return }
        let time = UserDefaults.standard.remindTime()
        UNUserNotificationCenter.setReminder(for: allTasks, at: time)
    }
}

#Preview {
    ContentView()
}
