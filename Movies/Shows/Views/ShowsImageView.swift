//
//  ShowsImageView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowsImageView: View {
    
    private let show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var body: some View {
        AnimatedImage(url: URL(string: show.image))
            .placeholder {
                PlaceholderImage(width: 80, height: 104, radius: 4)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
            }
            .clippedAndScaledToFill(width: 80, height: 104, radius: 4)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
    }
}
