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
        let fontName = Constants.Fonts.NunitoSans.bold
        
        VStack(alignment: .leading, spacing: 8) {
            let lines = 1
            
            if let title = viewModel.movie?.fullTitle {
                Text(title)
                    .font(Font.custom(fontName, size: 25))
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
                        .foregroundColor(Constants.SwiftUIColors.grey)
                    Text(rating)
                        .lineLimit(lines)
                }
            }
            
            if let genres = viewModel.movie?.genres {
                Text(genres)
                    .lineLimit(lines)
            }
            
            if let runtime = viewModel.movie?.runtimeStr {
                Text(runtime)
                    .lineLimit(lines)
            }
        }
        .font(Font.custom(fontName, size: 15))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.trailing, 18)
    }
}

struct MovieDetailDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailDescriptionView()
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: ""))
    }
}
