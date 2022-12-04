//
//  DataRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct URLComponents {
    private static let baseURL = "https://imdb-api.com/"
    private static let apiKey = "k_k9pjq5s2/"
    
    static func buildUrl(with path: String, id: String?) -> String {
        let url = baseURL + "api/\(path)" + apiKey
        guard let id else { return url }
        
        return url + id
    }
}

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        
        return try decoder.decode(Response.self, from: data)
    }
}
