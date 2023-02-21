//
//  InTheatresMoviesRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct InTheatresMoviesRequest: DataRequest {
    
    typealias ResponseData = InTheatresMoviesDataModel
    
    var baseURL: String { BaseUrl.imdbApi }
    var path: URLPath { .inTheatresMovies }
    
}
