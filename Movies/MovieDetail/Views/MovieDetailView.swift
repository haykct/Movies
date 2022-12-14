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
                HStack(spacing: 0) {
                    Spacer()
                        if let image = viewModel.movie?.image {
                            AsyncImage(url: URL(string: image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 250)
//                                    .background(.green)
                                    .padding(.trailing, 50)
                                    .clipped()
                            } placeholder: {
                                Image("placeholder")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 250)
//                                    .background(.green)
                                    .padding(.trailing, 50)
                                    .clipped()
                            }

                        }
                    VStack {
//                        Text("Hello")
                    }
                    .frame(maxWidth: 100, maxHeight: .infinity)
//                    .background(.green)
                    Spacer()
                }
                .frame(width: proxy.size.width, height: 250)
//                .background(.red)
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
