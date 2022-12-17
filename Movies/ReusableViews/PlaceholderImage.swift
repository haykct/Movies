//
//  PlaceholderImage.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI

struct PlaceholderImage: View {
    
    private var width: CGFloat
    private var height: CGFloat
    private var radius: CGFloat?
    
    init(width: CGFloat, height: CGFloat, radius: CGFloat? = nil) {
        self.width = width
        self.height = height
        self.radius = radius
    }
    
    var body: some View {
        Image("placeholder")
            .clippedAndScaledToFill(width: width, height: height, radius: radius ?? 0)
    }
}

struct PlaceholderImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImage(width: 100, height: 100)
    }
}
