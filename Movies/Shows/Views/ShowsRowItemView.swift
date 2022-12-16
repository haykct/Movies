//
//  ShowsRowItem.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI

struct ShowsRowItem: View {
    
    @ObservedObject var viewModel: ShowsViewModel
    
    init(viewModel: ShowsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ForEach(viewModel.shows) { show in
//            NavigationLink {
//                let viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: viewModel.shows.first?.id)
//                
//                MovieDetailView()
//                    .environmentObject(viewModel)
//            } label: {
//                
//            }
            HStack(spacing: 0) {
                ShowsImageView(show: show)
                ShowsDescriptionView(show: show)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .cornerRadius(6)
            .listRowSeparatorTint(SwiftUIColors.grey)
            .listRowBackground(SwiftUIColors.backgroundGrey.edgesIgnoringSafeArea(.all))
            .background(.white)
            .listRowSeparator(.hidden)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(SwiftUIColors.borderGrey, lineWidth: 1)
            )
        }
    }
}

struct ShowsRowItem_Previews: PreviewProvider {
    static var previews: some View {
        ShowsRowItem(viewModel: ShowsViewModel(networkService: DefaultNetworkService()))
    }
}
