//
//  MovieDetailView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import SwiftUI

struct MovieDetailView: View {
    
    private typealias SwiftUIColors = Constants.SwiftUIColors
    
    private let containerSpacing: CGFloat = 0
    private let imageDescriptionSectionSpacing: CGFloat = 10
    private let imageDescriptionSectionHeight: CGFloat = 210
    private let imageDescriptionSectionPadding: CGFloat = 20
    
    @State private var isOnAppearCalled = false
    @State private var isAlertPresented = false
    @EnvironmentObject private var viewModel: MovieDetailViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: containerSpacing) {
                    HStack(spacing: imageDescriptionSectionSpacing) {
                        MovieDetailImageView()
                        MovieDetailDescriptionView()
                    }
                    .frame(width: proxy.size.width, height: imageDescriptionSectionHeight)
                    .padding(.top, imageDescriptionSectionPadding)
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
            .errorAlert(isPresented: $isAlertPresented, message: Constants.Alert.message)
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
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: ""))
    }
}
