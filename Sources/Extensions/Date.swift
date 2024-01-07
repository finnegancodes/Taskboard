//
//  Date.swift
//  Taskboard
//
//  Created by Adam Oravec on 15/12/2023.
//

import Foundation

extension Date {
    static var today: Date {
        let now = Date.now
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        let date = Calendar.current.date(from: components) ?? Date.now
        return date
    }
    
    static var tomorrow: Date {
        let now = Date.now
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        let date = Calendar.current.date(from: components) ?? Date.now
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? Date.now
        return tomorrow
    }
    
    var day: Int {
        let components = Calendar.current.dateComponents([.day], from: self)
        let day = components.day ?? 0
        return day
    }
    
    var remindTime: RemindTime {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self)
        let time = RemindTime(hour: components.hour ?? 17, minute: components.minute ?? 0)
        return time
    }
}
