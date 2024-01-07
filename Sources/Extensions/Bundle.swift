//
//  Bundle.swift
//  Taskboard
//
//  Created by Adam Oravec on 06/01/2024.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? "nil"
    }
    var buildVersionNumber: String {
        return (infoDictionary?["CFBundleVersion"] as? String) ?? "nil"
    }
}
