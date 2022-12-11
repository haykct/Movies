//
//  InTheatresDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct InTheatresMoviesDataModel: Hashable, Decodable {
    var items: [InTheatresMovie]
    var errorMessage: String
}

struct InTheatresMovie: Hashable, Decodable {
    var id: String
    var image: String
}
