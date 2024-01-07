//
//  SettingsSheet.swift
//  Taskboard
//
//  Created by Adam Oravec on 03/01/2024.
//

import SwiftUI
import SwiftData

struct SettingsSheet: ViewModifier {
    
    @Bindable var navigator: Navigator
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $navigator.showingSettingsScreen) {
                NavigationStack {
                    SettingsSheetContent()
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    navigator.showingSettingsScreen = false
                                }
                            }
                        }
                }
            }
    }
}

struct SettingsSheetContent: View {
        
    @AppStorage("remindersEnabled") private var remindersEnabled: Bool = false
    
    @State private var viewModel: SettingsSheetViewModel = SettingsSheetViewModel()
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
            Section {
                Toggle("Reminders", isOn: $viewModel.remindersEnabled.animation())
                    .disabled(viewModel.notificationStatus == .denied)
                if viewModel.remindersEnabled {
                    DatePicker("Remind at Time", selection: $viewModel.remindDate, displayedComponents: [.hourAndMinute])
                }
            } footer: {
                Text("Sends notifications about unfinished tasks at specified time.")
            }
            Section {
                Button("Export Tasks...") {
                    viewModel.exportData = viewModel.generateData(modelContext: modelContext)
                    viewModel.showingExporter = true
                }
                Button("Import Tasks...") {
                    viewModel.showingImportWarning = true
                }
            }
            Section("App Info") {
                LabeledContent("Version", value: "\(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
                LabeledContent("Source") {
                    Text("[github.com](https://github.com)")
                }
                LabeledContent("Made by", value: "Adam Oravec")
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadNotificationStatus()
        }
        .onAppear {
            viewModel.remindersEnabled = remindersEnabled
            viewModel.loadRemindTime()
        }
        .fileExporter(isPresented: $viewModel.showingExporter, item: viewModel.exportData, contentTypes: [.json], defaultFilename: "taskboard_data") {
            viewModel.handleExport(result: $0)
        }
        .fileImporter(isPresented: $viewModel.showingImporter, allowedContentTypes: [.json]) {
            viewModel.handleImport(result: $0, modelContext: modelContext)
        }
        .errorAlert($viewModel.exportError, title: "Failed to export tasks")
        .errorAlert($viewModel.importError, title: "Failed to import tasks")
        .alert("Warning!", isPresented: $viewModel.showingImportWarning) {
            Button("Cancel", role: .cancel) {}
            Button("Proceed") {
                viewModel.showingImporter = true
            }
        } message: {
            Text("Importing task will override your already existing tasks and tags. Do you wish to proceed?")
        }
        .alert("Tasks Imported", isPresented: $viewModel.showingImportConfirmation, actions: {})
        .onChange(of: viewModel.remindersEnabled) { _, remindersEnabled in
            self.remindersEnabled = remindersEnabled
        }
    }
}

extension View {
    func settingsSheet(navigator: Navigator) -> some View {
        modifier(SettingsSheet(navigator: navigator))
    }
}
