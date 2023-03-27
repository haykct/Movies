//
//  MoviewDetailPlotView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 15.12.22.
//

import SwiftUI

struct MoviewDetailPlotView: View {
    
    private typealias NunitoSans = Constants.Fonts.NunitoSans
    
    @EnvironmentObject private var viewModel: MovieDetailViewModel
    
    var body: some View {
        if let plot = viewModel.movie?.plot {
            VStack(spacing: 0) {
                let layout = (leading: 18.0, bottom: 0.0, trailing: 18.0)
                
                Text("Plot")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 25, leading: layout.leading,
                                        bottom: layout.bottom, trailing: layout.trailing))
                    .font(Font.custom(NunitoSans.bold, size: 20))
                HStack {
                    Text(plot)
                        .padding(EdgeInsets(top: 6, leading: layout.leading,
                                            bottom: layout.bottom, trailing: layout.trailing))
                        .font(Font.custom(NunitoSans.semiBold, size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct MoviewDetailPlotView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewDetailPlotView()
            .environmentObject(MovieDetailViewModel(networkService: DefaultNetworkService(), id: ""))
    }
}
