//
//  MovieDetailCastView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 15.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailCastView: View {
    
    private typealias NunitoSans = Constants.Fonts.NunitoSans
    
    private let rows = [GridItem(.flexible())]
    
    @EnvironmentObject private var viewModel: MovieDetailViewModel
    
    var body: some View {
        // Api gives high resolution images(which are loading slow) and url for resize request.
        // Since the api call amount is limited by 100 calls a day, I didn't implement image
        // resizing request logic, cause I consume the amount of the requests after scrolling through images multiple times.
        if let actors = viewModel.movie?.actorList {
            VStack(spacing: 10) {
                let paddingLayout = (leading: 18.0, bottom: 0.0, trailing: 18.0)
                let imageLayout = (width: 130.0, height: 170.0, radius: 8.0)
                
                Text("Cast")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 25, leading: paddingLayout.leading,
                                        bottom: paddingLayout.bottom, trailing: paddingLayout.trailing))
                    .font(Font.custom(NunitoSans.bold, size: 20))
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(actors) { actor in
                            VStack {
                                if let image = actor.image {
                                    AnimatedImage(url: URL(string: image))
                                        .placeholder(content: {
                                            PlaceholderImage(width: imageLayout.width, height: imageLayout.height,
                                                             radius: imageLayout.radius)
                                        })
                                        .clippedAndScaledToFill(width: imageLayout.width, height: imageLayout.height,
                                                                radius: imageLayout.radius)
                                } else {
                                    PlaceholderImage(width: imageLayout.width, height: imageLayout.height,
                                                     radius: imageLayout.radius)
                                }
                                
                                if let name = actor.name {
                                    Text(name)
                                        .font(Font.custom(NunitoSans.regular, size: 13))
                                        .frame(maxWidth: imageLayout.width)
                                }
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: paddingLayout.leading,
                                    bottom: 20, trailing: paddingLayout.trailing))
            }
        }
    }
}

struct MovieDetailCastView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailCastView()
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: ""))
    }
}
