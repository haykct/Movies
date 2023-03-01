//
//  MovieDetailView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State private var isOnAppearCalled = false
    @State private var isAlertPresented = false
    @EnvironmentObject private var viewModel: MovieDetailViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    HStack(spacing: 10) {
                        MovieDetailImageView()
                        MovieDetailDescriptionView()
                    }
                    .frame(width: proxy.size.width, height: 210)
                    .padding(.top, 20)
                    MoviewDetailPlotView()
                    MovieDetailCastView()
                }
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(SwiftUIColors.grey)
            .background(
                LinearGradient(gradient: Gradient(colors: [SwiftUIColors.cyan, .white]),
                               startPoint: .top, endPoint: .bottom)
            )
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .errorAlert(isPresented: $isAlertPresented, message: "Oops, something went wrong.")
            .onReceive(viewModel.error, perform: { error in
                isAlertPresented = true
            })
            .onAppear {
                requestMovies()
            }
        }
    }
    
    private func requestMovies() {
        if !isOnAppearCalled {
            isOnAppearCalled = true
            viewModel.requestMovies()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: "tt5491994"))
    }
}
