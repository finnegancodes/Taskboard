//
//  UserDefaults.swift
//  Taskboard
//
//  Created by Adam Oravec on 03/01/2024.
//

import Foundation

extension UserDefaults {
    func remindTime() -> RemindTime {
        if let data = data(forKey: "remindTime") {
            return RemindTime(from: data)
        } else {
            return RemindTime()
        }
    }
    
    func setRemindTime(_ remindTime: RemindTime) {
        let data = remindTime.data
        setValue(data, forKey: "remindTime")
    }
    
    func value<T>(_ type: T.Type, forKey key: String) -> T? {
        let value = self.value(forKey: key) as? T
        return value
    }
}
