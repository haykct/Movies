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
        ScrollView {
            HStack {
                VStack {
                    
                }
            }
            .frame(width: 300, height: 200)
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [SwiftUIColors.cyan, .white]),
                           startPoint: .top, endPoint: .bottom)
        )
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.requestMosvie()
            UINavigationBar.appearance().isTranslucent = false
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(networkService: DefaultNetworkService(),
                                                        id: nil))
    }
}
