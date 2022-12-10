//
//  InTheatresMoviesRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct InTheatresMoviesRequest: DataRequest {
    
    typealias ResponseData = InTheatresDataModel
    
    let url = URLComponents.buildUrl(withPath: "InTheaters") 
}
