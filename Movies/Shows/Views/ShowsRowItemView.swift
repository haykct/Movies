//
//  ShowsRowItem.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI

struct ShowsRowItem: View {
    
    private let show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var body: some View {
        NavigationLink {
            let viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: show.id)
            
            MovieDetailView()
                .environmentObject(viewModel)
        } label: {
            let length: CGFloat = 20
            
            Spacer(minLength: length)
            HStack(spacing: 0) {
                ShowsImageView(show: show)
                ShowsDescriptionView(show: show)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(.white)
            .cornerRadius(8)
            Spacer(minLength: length)
        }
    }
}
