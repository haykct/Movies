//
//  ShowsRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation

struct ShowsRequest: DataRequest {
    
    typealias ResponseData = ShowsDataModel
    
    let url: String
    
    init() {
        url = URLBuilder.buildUrl(withPath: "Top250TVs")
    }
}
