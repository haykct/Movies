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
        let layout = (width: 160.0, height: 210.0, radius: 12.0, padding: 18.0)
        
        if let image = viewModel.movie?.image {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .clippedAndScaledToFill(width: layout.width, height: layout.height, radius: layout.radius)
                    .padding(.leading, layout.padding)
            } placeholder: {
                PlaceholderImage(width: layout.width, height: layout.height, radius: layout.radius)
                    .padding(.leading, layout.padding)
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
