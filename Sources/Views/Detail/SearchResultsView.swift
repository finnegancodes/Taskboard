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
    
    @Query var tasks: [Task]
    
    init(searchText: String) {
        self.searchText = searchText
        _tasks = Query(filter: #Predicate { task in
            task.content.localizedStandardContains(searchText)
        }, sort: Task.defaultSortDescriptors)
    }
    
    var body: some View {
        TaskListerView(tasks: tasks)
            .foregroundStyle(.primary)
    }
}

#Preview {
    SearchResultsView(searchText: "")
}
