//
//  MovieDetailCastView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 15.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailCastView: View {
    
    let rows = [GridItem(.flexible())]
    
    @EnvironmentObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        // Api gives high resolution images(which are loading slow) and url for resize request.
        // Since the api call amount is limited by 100 calls a day, I didn't implement image
        // resizing request logic, cause I consume the amount of the requests after scrolling through images multiple times.
        if let actors = viewModel.movie?.actorList {
            VStack(spacing: 10) {
                Text("Cast")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 25, leading: 18, bottom: 0, trailing: 18))
                    .font(Font.custom("NunitoSans-Bold", size: 20))
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(actors) { actor in
                            VStack {
                                if let image = actor.image {
                                    AnimatedImage(url: URL(string: image))
                                        .placeholder(content: {
                                            PlaceholderImage(width: 130, height: 170, radius: 8)
                                        })
                                        .clippedAndScaledToFill(width: 130, height: 170, radius: 8)
                                } else {
                                    PlaceholderImage(width: 130, height: 170, radius: 8)
                                }
                                
                                if let name = actor.name {
                                    Text(name)
                                        .font(Font.custom("NunitoSans-Regular", size: 13))
                                        .frame(maxWidth: 130)
                                }
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 20, trailing: 18))
            }
        }
    }
}

struct MovieDetailCastView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailCastView()
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: "tt5491994"))
    }
}
