//
//  View.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 28.02.23.
//

import SwiftUI

extension View {
    func errorAlert(isPresented: Binding<Bool>, message: String) -> some View {
        return alert("Alert", isPresented: isPresented, actions: {
            Button("Close", role: .cancel, action: {})
        }, message: {
            Text(message)
        })
    }
}
