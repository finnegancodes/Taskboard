//
//  ScreenList.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI
import SwiftData

struct ScreenList: View {
    
    @Bindable var navigator: Navigator
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        List(selection: $navigator.selectedScreen) {
            Section {
                let count: Int = (try? modelContext.fetchCount(FetchDescriptor<Task>(predicate: TaskPredicate.unfinishedPredicate))) ?? 0
                ScreenLabel(screen: .overview, taskCount: count)
            }
            Section {
                let todayCount: Int = (try? modelContext.fetchCount(FetchDescriptor<Task>(predicate: TaskPredicate.todayUnfinishedPredicate))) ?? 0
                ScreenLabel(screen: .today, taskCount: todayCount)
                
                let tomorrowCount: Int = (try? modelContext.fetchCount(FetchDescriptor<Task>(predicate: TaskPredicate.tomorrowUnfinishedPredicate))) ?? 0
                ScreenLabel(screen: .tomorrow, taskCount: tomorrowCount)
                
                let laterCount: Int = (try? modelContext.fetchCount(FetchDescriptor<Task>(predicate: TaskPredicate.laterUnfinishedPredicate))) ?? 0
                ScreenLabel(screen: .later, taskCount: laterCount)
                
                let pastDueCount: Int = (try? modelContext.fetchCount(FetchDescriptor<Task>(predicate: TaskPredicate.pastDuePredicate))) ?? 0
                ScreenLabel(screen: .pastDue, taskCount: pastDueCount)
            }
            Section {
                ScreenLabel(screen: .tags, taskCount: 0)
                
                let finishedCount: Int = (try? modelContext.fetchCount(FetchDescriptor<Task>(predicate: TaskPredicate.finishedPredicate))) ?? 0
                ScreenLabel(screen: .finished, taskCount: finishedCount)
            }
        }
    }
}

#Preview {
    ScreenList(navigator: Navigator())
}
