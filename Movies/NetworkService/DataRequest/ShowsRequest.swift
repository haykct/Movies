//
//  ShowsRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation

struct ShowsRequest: DataRequest {
    
    typealias ResponseData = ShowsDataModel
    
    var baseURL: String { BaseUrl.imdbApi }
    var path: URLPath { .top250TvShows }
}
