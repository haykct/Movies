//
//  DataRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct URLComponents {
    private static let baseURL = "https://imdb-api.com/"
    private static let apiKey = "k_95zcsbzv/"
    private static let defaultPath = "en/API/"
    
    static func buildUrl(withPath path: String, id: String? = nil) -> String {
        let url = baseURL + defaultPath + "\(path)/" + apiKey
        guard let id else { return url }
        
        return url + id
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
