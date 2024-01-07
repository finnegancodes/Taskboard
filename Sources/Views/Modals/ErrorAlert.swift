//
//  ErrorAlert.swift
//  Taskboard
//
//  Created by Adam Oravec on 06/01/2024.
//

import SwiftUI

extension View {
    func errorAlert(_ error: Binding<Error?>, title: LocalizedStringKey) -> some View {
        alert(title, isPresented: Binding {
            error.wrappedValue != nil
        } set: { _ in
            error.wrappedValue = nil
        }) {
            Button("OK") {}
        } message: {
            if let error = error.wrappedValue {
                Text(error.localizedDescription)
            }
        }

    }
}
