//
//  URLPath.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 21.02.23.
//

import Foundation

enum BaseUrl {
    static let imdbApi = "https://imdb-api.com/"
}

enum URLPath {
    case inTheatresMovies
    case mostPopularMovies
    case movieDetail(id: String)
    case top250TvShows
    
    // This apiKey is for testing purposes. In a real life example apiKey should be hidden from the source code. 
    private var apiKey: String { "k_95zcsbzv" } // k_8wo9qbmz, k_k9pjq5s2  Here are two more api keys if api calls amount is consumed(100 calls per day)
    
    var value: String {
        switch self {
        case .inTheatresMovies:
            return buildPath(path: "en/API/InTheaters/")
        case .mostPopularMovies:
            return buildPath(path: "en/API/MostPopularMovies/")
        case .movieDetail(let id):
            return buildPath(path: "en/API/Title/", id: id)
        case .top250TvShows:
            return buildPath(path: "en/API/Top250TVs/")
        }
    }

    private func buildPath(path: String, id: String = String()) -> String {
        path + apiKey + "/\(id)"
    }
}
