//
//  ShowsImageView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowsImageView: View {
    
    private var show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var body: some View {
        AnimatedImage(url: URL(string: show.image))
            .placeholder {
                PlaceholderImage(width: 80, height: 104, radius: 4)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 12))
            }
            .clippedAndScaledToFill(width: 80, height: 104, radius: 4)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 12))
    }
}
