//
//  ShowsView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowsView: View {
    
    @ObservedObject var showsViewModel: ShowsViewModel
    
    var body: some View {
        List {
            ForEach(showsViewModel.shows) { show in
                HStack {
                    AnimatedImage(url: URL(string: show.image))
                        .placeholder {
                            PlaceholderImage(width: 130, height: 170, radius: 8)
                        }
                        .clippedAndScaledToFill(width: 80, height: 104)
                    Text(show.fullTitle)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .cornerRadius(6)
                .listRowSeparatorTint(SwiftUIColors.grey)
                .listRowBackground(SwiftUIColors.backgroundGrey.edgesIgnoringSafeArea(.all))
            }
        }
        .background(SwiftUIColors.backgroundGrey)
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            showsViewModel.requestTop250Shows()
        }
    }
}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView(showsViewModel: ShowsViewModel(networkService: DefaultNetworkService()))
    }
}
