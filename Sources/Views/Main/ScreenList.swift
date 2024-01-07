//
//  ScreenList.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

struct ScreenList: View {
    
    @Bindable var navigator: Navigator
    
    var body: some View {
        List(selection: $navigator.selectedScreen) {
            Section {
                ScreenLabel(screen: .overview, taskCount: 0)
            }
            Section {
                ScreenLabel(screen: .today, taskCount: 0)
                ScreenLabel(screen: .tomorrow, taskCount: 0)
                ScreenLabel(screen: .later, taskCount: 0)
                ScreenLabel(screen: .pastDue, taskCount: 0)
            }
            Section {
                ScreenLabel(screen: .tags, taskCount: 0)
                ScreenLabel(screen: .finished, taskCount: 0)
            }
        }
    }
}

#Preview {
    ScreenList(navigator: Navigator())
}
