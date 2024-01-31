//
//  UserNotifications.swift
//  Taskboard
//
//  Created by Adam Oravec on 03/01/2024.
//

import SwiftUI

extension UNUserNotificationCenter {
    
    static func setReminder(for tasks: [Task], at time: RemindTime) {
        print("Setting reminder for \(time)")
        
        let notificationCenter = Self.current()
        var requests: [UNNotificationRequest] = []
        
        notificationCenter.removeAllPendingNotificationRequests()
        
        let todayTasksCount: Int = tasks.filter { $0.dueDate <= Date.today }.count
        let tomorrowTasksCount: Int = tasks.filter { $0.dueDate == Date.tomorrow }.count
        let contentBody = "You have %d unfinished %@ for today."
        
        if todayTasksCount > 0 {
            let todayContent = UNMutableNotificationContent()
            todayContent.title = "Taskboard"
            todayContent.body = String(format: contentBody, todayTasksCount, todayTasksCount > 1 ? "tasks" : "task")
            
            var todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.today)
            todayComponents.hour = time.hour
            todayComponents.minute = time.minute
            
            let todayTrigger = UNCalendarNotificationTrigger(dateMatching: todayComponents, repeats: false)
            
            requests.append(UNNotificationRequest(identifier: UUID().uuidString, content: todayContent, trigger: todayTrigger))
        }
        
        if tomorrowTasksCount > 0 {
            let tomorrowContent = UNMutableNotificationContent()
            tomorrowContent.title = "Taskboard"
            tomorrowContent.body = String(format: contentBody, tomorrowTasksCount, tomorrowTasksCount > 1 ? "tasks" : "task")
            
            var tomorrowComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.tomorrow)
            tomorrowComponents.hour = time.hour
            tomorrowComponents.minute = time.minute
            
            let tomorrowTrigger = UNCalendarNotificationTrigger(dateMatching: tomorrowComponents, repeats: false)
            
            requests.append(UNNotificationRequest(identifier: UUID().uuidString, content: tomorrowContent, trigger: tomorrowTrigger))
        }
        
        for request in requests {
            notificationCenter.add(request) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func requestAuthorization() async -> Bool {
        let notificationCenter = Self.current()
        
        return await withCheckedContinuation { configuration in
            notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                configuration.resume(returning: success)
            }
        }
    }
    
    static func getAuthorizationStatus() async -> NotificationStatus {
        let notificationCenter = Self.current()
        let settings = await notificationCenter.notificationSettings()
        switch settings.authorizationStatus {
        case .notDetermined:
            return .undefined
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        case .provisional:
            return .authorized
        case .ephemeral:
            return .authorized
        @unknown default:
            return .undefined
        }
    }
}
