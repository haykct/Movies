//
//  MovieDetailView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject var viewModel: MovieDetailViewModel

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                HStack(spacing: 10) {
                    Spacer()
                    if let image = viewModel.movie?.image {
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .clippedAndScaledToFill()
                        } placeholder: {
                            Image("placeholder")
                                .clippedAndScaledToFill()
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        if let title = viewModel.movie?.fullTitle {
                            Text(title)
                                .font(Font.custom("NunitoSans-Bold", size: 25))
                        }
                        
                        if let directors = viewModel.movie?.directors {
                            Text(directors)
                        }
                        
                        if let rating = viewModel.movie?.rating {
                            HStack {
                                Image("star")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .padding(.bottom, 3)
                                Text(rating)
                                    .lineLimit(1)
                            }
                        }
                        
                        if let genres = viewModel.movie?.genres {
                            Text(genres)
                                .lineLimit(1)
                        }
                        
                        if let runtime = viewModel.movie?.runtimeStr {
                            Text(runtime)
                                .lineLimit(1)
                        }
                    }
                    .font(Font.custom("NunitoSans-SemiBold", size: 15))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .foregroundColor(SwiftUIColors.grey)
                    Spacer()
                }
                .frame(width: proxy.size.width, height: 210)
                .padding(.top, 30)
                VStack {
                    
                }
                .frame(width: 400, height: 200)
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [SwiftUIColors.cyan, .white]),
                               startPoint: .top, endPoint: .bottom)
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.requestMosvie()
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(networkService: DefaultNetworkService(),
                                                        id: nil))
    }
}
