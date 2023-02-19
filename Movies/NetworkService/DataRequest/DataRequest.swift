//
//  DataRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

enum URLBuilder {
    private var baseURL: String { "https://imdb-api.com/" }
    // k_8wo9qbmz, k_k9pjq5s2  Here are two more api keys if api calls amount is consumed(100 calls per day)
    private var defaultPath: String { "en/API/" }
    private var apiKey: String { "k_95zcsbzv" }
    
    case inTheatresMovies
    case mostPopularMovies
    case movieDetail(id: String)
    case top250TvShows
    
    var url: String {
        switch self {
        case .inTheatresMovies:
            return buildUrl(withPath: "InTheaters")
        case .mostPopularMovies:
            return buildUrl(withPath: "MostPopularMovies")
        case let .movieDetail(id):
            return buildUrl(withPath: "Title") + "/\(id)"
        case .top250TvShows:
            return buildUrl(withPath: "Top250TVs")
        }
    }
    
    private func buildUrl(withPath path: String) -> String {
        baseURL + defaultPath + "\(path)/" + apiKey
    }
}

protocol Response {
    var errorMessage: String? { get set }
}

protocol DataRequest {
    associatedtype ResponseData: Response
    
    var url: String { get }
    
    func decode(_ data: Data) throws -> ResponseData
}

extension DataRequest where ResponseData: Decodable {
    func decode(_ data: Data) throws -> ResponseData {
        let decoder = JSONDecoder()
        
        return try decoder.decode(ResponseData.self, from: data)
    }
}
