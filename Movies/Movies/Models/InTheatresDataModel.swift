//
//  InTheatresDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct InTheatresMoviesDataModel: Decodable {
    var items: [InTheatresMovie]
    var errorMessage: String
}

struct InTheatresMovie: Decodable {
    var id: String
    var image: String
}
