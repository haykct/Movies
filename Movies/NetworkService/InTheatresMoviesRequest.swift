//
//  InTheatresMoviesRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct Model: Decodable {}

struct InTheatresMoviesRequest: DataRequest {
    
    typealias Response = Model
    
    let url = URLComponents.buildUrl(withPath: "InTheaters")
    
}
