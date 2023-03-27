//
//  DataRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation
import Alamofire

protocol ErrorInformationProvider {
    var errorMessage: String? { get set }
}

protocol Request {
    var baseURL: String { get }
    var path: URLPath { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

extension Request {
    var url: String { baseURL + path.value }
    var baseURL: String { Constants.BaseUrls.imdbApi }
    var httpMethod: HTTPMethod { .get }
    var headers: HTTPHeaders? { nil }
    var parameters: Parameters? { nil }
}
