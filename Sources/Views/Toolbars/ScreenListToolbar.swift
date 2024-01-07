//
//  ScreenListToolbar.swift
//  Taskboard
//
//  Created by Adam Oravec on 03/01/2024.
//

import SwiftUI

struct ScreenListToolbar: ViewModifier {
    
    @Environment(Navigator.self) var navigator: Navigator
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button {
                    navigator.showingSettingsScreen = true
                } label: {
                    Label("Settings", systemImage: "gear")
                }
            }
    }
}

extension View {
    func screenListToolbar() -> some View {
        modifier(ScreenListToolbar())
    }
}
