//
//  Image.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 14.12.22.
//

import SwiftUI

extension Image {
    func clippedAndScaledToFill() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 160, height: 210)
            .clipped()
            .cornerRadius(12)
    }
}
