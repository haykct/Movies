//
//  MovieDetailRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

struct MovieDetailRequest: DataRequest {
    
    typealias ResponseData = MovieDetailDataModel
    
    let url: String
    
    init(id: String) {
        url = URLComponents.buildUrl(withPath: "Title", id: id)
    }
}
