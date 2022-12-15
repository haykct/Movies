//
//  MovieDetailView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import SwiftUI

struct MovieDetailView: View {
    
    @EnvironmentObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                HStack(spacing: 10) {
                    MovieDetailImageView()
                    MovieDetailDescriptionView()
                }
                .frame(width: proxy.size.width, height: 210)
                .padding(.top, 20)
                MoviewDetailPlotView()
                MovieDetailCastView()
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(SwiftUIColors.grey)
            .background(
                LinearGradient(gradient: Gradient(colors: [SwiftUIColors.cyan, .white]),
                               startPoint: .top, endPoint: .bottom)
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.requestMosvie()
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
