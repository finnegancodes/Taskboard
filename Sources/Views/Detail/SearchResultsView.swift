//
//  SearchResultsView.swift
//  Taskboard
//
//  Created by Adam Oravec on 18/12/2023.
//

import SwiftUI
import SwiftData

struct SearchResultsView: View {
    
    let searchText: String
    @Binding var isEmpty: Bool
    
    @Query var tasks: [Task]
    
    init(searchText: String, isEmpty: Binding<Bool>) {
        self.searchText = searchText
        _isEmpty = isEmpty
        _tasks = Query(filter: #Predicate { task in
            task.content.localizedStandardContains(searchText)
        }, sort: Task.defaultSortDescriptors)
    }
    
    var body: some View {
        TaskListerView(tasks: tasks)
            .foregroundStyle(.primary)
            .onChange(of: tasks) { _, tasks in
                isEmpty = tasks.isEmpty
            }
    }
}

#Preview {
    SearchResultsView(searchText: "", isEmpty: .constant(false))
}
