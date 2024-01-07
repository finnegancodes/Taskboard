//
//  RemindTime.swift
//  Taskboard
//
//  Created by Adam Oravec on 03/01/2024.
//

import Foundation

struct RemindTime: Codable {
    var hour: Int
    var minute: Int
    
    init() {
        self.hour = 17
        self.minute = 0
    }
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    init(from data: Data) {
        if let remindTime = try? JSONDecoder().decode(RemindTime.self, from: data) {
            self = remindTime
        } else {
            self.init()
        }
    }
    
    var date: Date {
        let date = Calendar.current.date(from: DateComponents(hour: hour, minute: minute)) ?? Date.now
        return date
    }
    
    var data: Data {
        (try? JSONEncoder().encode(self)) ?? Data()
    }
}
