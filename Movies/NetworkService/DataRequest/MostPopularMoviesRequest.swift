//
//  MostPopularMoviesRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 11.12.22.
//

import Foundation

struct MostPopularMoviesRequest: DataRequest {
    
    typealias ResponseData = MostPopularMoviesDataModel
    
    let url = URLBuilder.mostPopularMovies.url
}
