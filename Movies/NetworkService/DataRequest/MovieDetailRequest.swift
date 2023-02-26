//
//  MovieDetailRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

struct MovieDetailRequest: Request {
    
    private let id: String
    var path: URLPath { .movieDetail(id: id) }

    init(id: String) {
        self.id = id
    }
}
