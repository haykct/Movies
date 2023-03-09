//
//  MovieDetailImageDescritptionView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 15.12.22.
//

import SwiftUI

struct MovieDetailImageView: View {
    
    @EnvironmentObject private var viewModel: MovieDetailViewModel
    
    var body: some View {
        if let image = viewModel.movie?.image {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .clippedAndScaledToFill(width: 160, height: 210, radius: 12)
                    .padding(.leading, 18)
            } placeholder: {
                PlaceholderImage(width: 160, height: 210, radius: 12)
                    .padding(.leading, 18)
            }
        }
    }
}

struct MovieDetailImageDescritptionView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            MovieDetailImageView()
                .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: ""))
        }
    }
}
