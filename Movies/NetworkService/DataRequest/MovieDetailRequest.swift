//
//  MovieDetailRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

struct MovieDetailRequest: DataRequest {
    
    typealias ResponseData = MovieDetailDataModel
    
    let url = URLComponents.buildUrl(withPath: "Title")
}
