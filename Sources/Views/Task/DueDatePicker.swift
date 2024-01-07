//
//  DueDatePicker.swift
//  Taskboard
//
//  Created by Adam Oravec on 16/12/2023.
//

import SwiftUI

struct DueDatePicker: View {
    
    @Binding var due: Date
    
    @State private var selection: DueDate = .today
    
    var body: some View {
        Group {
            HStack(spacing: 5) {
                ForEach(DueDate.allCases, id: \.rawValue) { date in
                    Button {
                        withAnimation(.snappy) {
                            selection = date
                        }
                    } label: {
                        VStack(spacing: 2) {
                            Image(systemName: date.iconName)
                                .font(.system(size: 18))
                            Text(date.title)
                                .font(.system(size: 14))
                        }
                        .fontWeight(selection == date ? Font.Weight.medium : Font.Weight.regular)
                        .foregroundStyle(selection == date ? Color.white : Color.secondary)
                        .frame(height: 45)
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                    }
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(5)
                    .background(selection == date ? Color.accentColor : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .foregroundStyle(.primary)
            .padding(5)
            .background(.secondary.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onChange(of: selection) { _, newSelection in
                switch newSelection {
                case .today:
                    due = Date.today
                case .tomorrow:
                    due = Date.tomorrow
                default:
                    ()
                }
            }
            .onAppear {
                selection = DueDate(from: due)
            }
            if selection == .other {
                DatePicker("Due", selection: $due, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding(.horizontal, 5)
                    .background(.secondary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .transition(.scale)
            }
        }
    }
}

enum DueDate: String, CaseIterable {
    case today = "Today"
    case tomorrow = "Tomorrow"
    case other = "Other"
    
    init(from date: Date) {
        if date == Date.today {
            self = .today
        } else if date == Date.tomorrow {
            self = .tomorrow
        } else {
            self = .other
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .today:
            return "Today"
        case .tomorrow:
            return "Tomorrow"
        case .other:
            return "Other"
        }
    }
    
    var iconName: String {
        switch self {
        case .today:
            return "\(Date.today.day).square"
        case .tomorrow:
            return "\(Date.tomorrow.day).square"
        case .other:
            return "ellipsis.circle"
        }
    }
}
