//
//  Image.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 14.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

extension Image {
    func clippedAndScaledToFill(width: CGFloat, height: CGFloat, radius: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(radius)
    }
}

extension AnimatedImage {
    func clippedAndScaledToFill(width: CGFloat, height: CGFloat, radius: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(radius)
    }
}
