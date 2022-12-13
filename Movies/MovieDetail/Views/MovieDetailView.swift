//
//  MovieDetailView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject var viewModel: MovieDetailViewModel
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
           
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [SwiftUIColors.cyan, .white]),
                           startPoint: .top, endPoint: .bottom)
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(networkService: DefaultNetworkService(),
                                                        id: nil))
    }
}
