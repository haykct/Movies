//
//  ShowsView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowsView: View {
    
    @ObservedObject var viewModel: ShowsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.shows) { show in
                    NavigationLink {
                        let viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: show.id)
                        
                        MovieDetailView()
                            .environmentObject(viewModel)
                    } label: {
                        Spacer(minLength: 20)
                        HStack(spacing: 0) {
                            AnimatedImage(url: URL(string: show.image))
                                .placeholder {
                                    PlaceholderImage(width: 80, height: 104, radius: 4)
                                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                                }
                                .clippedAndScaledToFill(width: 80, height: 104, radius: 4)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                            
                            VStack {
                                if show.rank.isEmpty {
                                    Text(show.fullTitle)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(Font.custom("NunitoSans-SemiBold", size: 16))
                                        .padding(EdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 12))
                                } else {
                                    Text("\(show.rank). \(show.fullTitle)")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(Font.custom("NunitoSans-SemiBold", size: 16))
                                        .padding(EdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 12))
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(SwiftUIColors.borderGrey, lineWidth: 1)
                        )
                        Spacer(minLength: 20)
                    }
                }
            }
            .padding(.top, 25)
            .onAppear {
                viewModel.requestTop250Shows()
            }
            .navigationTitle("Top 250 TV Shows")
        }
        .background(SwiftUIColors.backgroundGrey)
    }
}

struct ShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowsView(viewModel: ShowsViewModel(networkService: DefaultNetworkService()))
    }
}
