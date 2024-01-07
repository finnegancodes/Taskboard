//
//  AppData.swift
//  Taskboard
//
//  Created by Adam Oravec on 05/01/2024.
//

import SwiftUI
import SwiftData

struct AppData: Codable, Transferable {
    let tasks: [Task.Data]
    let tags: [Tag.Data]
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .json) { appData in
            try JSONEncoder().encode(appData)
        } importing: { data in
            try JSONDecoder().decode(AppData.self, from: data)
        }
    }
}
