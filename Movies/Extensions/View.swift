//
//  View.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 28.02.23.
//

import SwiftUI

extension View {
    func errorAlert(error: Binding<LocalizedError?>, message: String? = nil) -> some View {
        return alert("Alert", isPresented: .constant(error.wrappedValue != nil), actions: {
            Button("Close") {
                error.wrappedValue = nil
            }
        }, message: {
            Text(message ?? error.wrappedValue?.errorDescription ?? "")
        })
    }
}
