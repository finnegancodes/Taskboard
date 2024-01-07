//
//  TaskListerView.swift
//  Taskboard
//
//  Created by Adam Oravec on 15/12/2023.
//

import SwiftUI

struct TaskListerView: View {
    
    let tasks: [Task]
    
    var body: some View {
        ForEach(tasks) { task in
            NavigationLink(value: task) {
                TaskView(task: task)
            }
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return 0
            }
        }
    }
}

#Preview {
    TaskListerView(tasks: [])
}
