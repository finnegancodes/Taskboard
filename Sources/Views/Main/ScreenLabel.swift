//
//  ScreenLabel.swift
//  Taskboard
//
//  Created by Adam Oravec on 13/12/2023.
//

import SwiftUI

struct ScreenLabel: View {
    
    let screen: Screen
    let taskCount: Int
    
    var body: some View {
        HStack(spacing: 10) {
            Label(screen.title, systemImage: screen.iconName)
            Spacer()
            if taskCount > 0 {
                Text("\(taskCount)")
                    .foregroundStyle(.white)
                    .frame(minWidth: 20)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(screen == .pastDue ? .red : .gray)
                    .clipShape(Capsule())
            }
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
                .font(.system(size: 14, weight: .medium))
        }
        .tag(screen)
    }
}

#Preview {
    ScreenLabel(screen: .overview, taskCount: 2)
}
