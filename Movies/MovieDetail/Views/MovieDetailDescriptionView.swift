//
//  MovieDetailDescriptionView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 15.12.22.
//

import SwiftUI

struct MovieDetailDescriptionView: View {
    
    @EnvironmentObject private var viewModel: MovieDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = viewModel.movie?.fullTitle {
                Text(title)
                    .font(Font.custom("NunitoSans-Bold", size: 25))
            }
            
            if let directors = viewModel.movie?.directors, !directors.isEmpty {
                Text("Directed by \(directors)")
            }
            
            if let rating = viewModel.movie?.rating {
                HStack {
                    Image("star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(.bottom, 3)
                        .foregroundColor(SwiftUIColors.grey)
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
        .padding(.trailing, 18)
    }
}

struct MovieDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailDescriptionView()
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: "tt5491994"))
    }
}
