//
//  InTheatresDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct InTheatresMoviesDataModel: Decodable, ErrorInformationProvider {
    var items: [InTheatresMovie]
    var errorMessage: String?
}

struct InTheatresMovie: Hashable, Decodable {
    let id: String
    let image: String
}
