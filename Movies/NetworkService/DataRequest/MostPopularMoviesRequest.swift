//
//  MostPopularMoviesRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 11.12.22.
//

import Foundation

struct MostPopularMoviesRequest: Request {
    var path: URLPath { .mostPopularMovies }
}
