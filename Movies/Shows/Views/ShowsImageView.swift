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
        let imageLayout = (width: 80.0, height: 104.0, radius: 4.0)
        let insetsLayout = (top: 10.0, leading: 10.0, bottom: 10.0, trailing: 0.0)
        
        AnimatedImage(url: URL(string: show.image))
            .placeholder {
                PlaceholderImage(width: imageLayout.width, height: imageLayout.height, radius: imageLayout.radius)
                    .padding(EdgeInsets(top: insetsLayout.top, leading: insetsLayout.leading,
                                        bottom: insetsLayout.bottom, trailing: insetsLayout.trailing))
            }
            .clippedAndScaledToFill(width: imageLayout.width, height: imageLayout.height, radius: imageLayout.radius)
            .padding(EdgeInsets(top: insetsLayout.top, leading: insetsLayout.leading,
                                bottom: insetsLayout.bottom, trailing: insetsLayout.trailing))
    }
}
