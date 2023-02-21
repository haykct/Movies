//
//  MovieDetailRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

struct MovieDetailRequest: DataRequest {
    
    typealias ResponseData = MovieDetailDataModel
    
    private let id: String
    var baseURL: String { BaseUrl.imdbApi }
    var path: URLPath { .movieDetail(id: id) }

    init(id: String) {
        self.id = id
    }
}
