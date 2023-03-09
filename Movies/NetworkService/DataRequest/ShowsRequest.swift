//
//  ShowsRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation

struct ShowsRequest: Request {
    var path: URLPath { .top250TvShows }
}
