//
//  ShowsView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowsView: View {
    
    @State private var isOnAppearCalled = false
    @ObservedObject private var viewModel: ShowsViewModel
    
    init(viewModel: ShowsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.shows) { show in
                    ShowsRowItem(show: show)
                }
            }
            .padding(.top, 25)
            .errorAlert(error: $viewModel.error, message: "Oops, something went wrong.")
            .onAppear {
                requestShows()
            }
            .navigationTitle("Top 250 TV Shows")
        }
        .background(SwiftUIColors.backgroundGrey)
    }
    
    private func requestShows() {
        if !isOnAppearCalled {
            isOnAppearCalled = true
            viewModel.requestTop250Shows()
        }
    }
}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView(viewModel: ShowsViewModel(networkService: DefaultNetworkService()))
    }
}
