//
//  MoviewDetailPlotView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 15.12.22.
//

import SwiftUI

struct MoviewDetailPlotView: View {
    
    @EnvironmentObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        if let plot = viewModel.movie?.plot {
            HStack {
                Text(plot)
                    .padding(EdgeInsets(top: 20, leading: 18, bottom: 0, trailing: 18))
                    .font(Font.custom("NunitoSans-SemiBold", size: 17))
            }
        }
    }
}

struct MoviewDetailPlotView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewDetailPlotView()
    }
}
