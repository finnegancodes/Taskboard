//
//  SettingsSheetViewModel.swift
//  Taskboard
//
//  Created by Adam Oravec on 06/01/2024.
//

import SwiftUI
import Observation
import SwiftData

@Observable
class SettingsSheetViewModel {
    
    var remindDate: Date = .now {
        didSet {
            let time = remindDate.remindTime
            UserDefaults.standard.setRemindTime(time)
        }
    }
    
    var notificationStatus = NotificationStatus.denied
    var showingExporter = false
    var showingImporter = false
    var showingImportWarning = false
    var showingImportConfirmation = false
    var exportData: AppData?
    var exportError: Error?
    var importError: Error?
    
    // MARK: --------------------------------------------------------
    
    var remindersEnabled = false {
        didSet {
            guard remindersEnabled && notificationStatus == .undefined else { return }
            requestNotificationAuthorization()
        }
    }
    
    func loadNotificationStatus() async {
        notificationStatus = await UNUserNotificationCenter.getAuthorizationStatus()
        if notificationStatus == .denied || notificationStatus == .undefined {
            remindersEnabled = false
        }
    }
    
    func loadRemindTime() {
        let time = UserDefaults.standard.remindTime()
        remindDate = time.date
    }
    
    private func requestNotificationAuthorization() {
        AsyncTask {
            let success = await UNUserNotificationCenter.requestAuthorization()
            if success {
                notificationStatus = .authorized
            } else {
                notificationStatus = .denied
                remindersEnabled = false
            }
        }
    }
    
    @MainActor func handleImport(result: Result<URL, Error>, modelContext: ModelContext) {
        switch result {
        case .success(let url):
            do {
                guard url.startAccessingSecurityScopedResource() else { throw ImportError.unableToAccessData }
                guard let data = try? Data(contentsOf: url) else { throw ImportError.unableToReadData }
                guard let appData = try? JSONDecoder().decode(AppData.self, from: data) else { throw ImportError.unableToDecodeData }
                importData(appData, modelContext: modelContext)
                url.stopAccessingSecurityScopedResource()
                showingImportConfirmation = true
            } catch {
                self.importError = error
            }
        case .failure(let error):
            print("Failed to import app data: \(error.localizedDescription)")
            importError = error
        }
    }
    
    func handleExport(result: Result<URL, Error>) {
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print("Failed to export app data: \(error.localizedDescription)")
            exportError = error
        }
    }
    
    @MainActor func generateData(modelContext: ModelContext) -> AppData {
        let tasks: [Task] = try! modelContext.fetch(FetchDescriptor())
        let tags: [Tag] = try! modelContext.fetch(FetchDescriptor())
        
        let tasksData = tasks.map { Task.Data(from: $0) }
        let tagsData = tags.map { Tag.Data(from: $0) }
        
        return AppData(tasks: tasksData, tags: tagsData)
    }
    
    @MainActor private func importData(_ appData: AppData, modelContext: ModelContext) {
        let oldTasks: [Task] = try! modelContext.fetch(FetchDescriptor())
        let oldTags: [Tag] = try! modelContext.fetch(FetchDescriptor())
        
        for tag in oldTags {
            modelContext.delete(tag)
        }
        
        for task in oldTasks {
            modelContext.delete(task)
        }
        
        let tasks: [Task] = appData.tasks.map { Task(from: $0) }
        let tags: [Tag] = appData.tags.map { Tag(from: $0) }
        
        for tag in tags {
            modelContext.insert(tag)
        }
        
        for task in tasks {
            modelContext.insert(task)
        }
        
        for (x, task) in tasks.enumerated() {
            let filteredTags: [Tag] = tags.filter { tag in
                print(appData.tasks[x].tags)
                return appData.tasks[x].tags.contains { $0 == tag.exportID }
            }
            task.tags = filteredTags
        }
        
        try? modelContext.save()
        
        print("Tasks imported")
    }
    
    enum ImportError: Error {
        case unableToAccessData
        case unableToReadData
        case unableToDecodeData
        case generic(Error)
    }
}
