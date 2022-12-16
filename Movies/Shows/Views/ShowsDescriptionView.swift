//
//  ShowsDescriptionView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI

struct ShowsDescriptionView: View {
    
    private var show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var body: some View {
        VStack {
            if show.rank.isEmpty {
                Text(show.fullTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("NunitoSans-SemiBold", size: 16))
                    .padding(.top, 10)
            } else {
                Text("\(show.rank). \(show.fullTitle)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom("NunitoSans-SemiBold", size: 16))
                    .padding(.top, 10)
            }
            
            Spacer()
            
            if !show.rating.isEmpty {
                VStack(spacing: 4) {
                    Image("star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(SwiftUIColors.ratingYellow)
                    Text(show.rating)
                        .font(Font.custom("NunitoSans-SemiBold", size: 16))
                }
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 104)
        .foregroundColor(SwiftUIColors.grey)
    }
}
