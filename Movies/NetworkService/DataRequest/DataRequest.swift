//
//  DataRequest.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

protocol ErrorInformationProvider {
    var errorMessage: String? { get set }
}

protocol DataRequest {
    associatedtype ResponseData: Decodable, ErrorInformationProvider
    
    var baseURL: String { get }
    var path: URLPath { get }
    
    func decode(_ data: Data) throws -> ResponseData
}

extension DataRequest {
    var url: String {
        baseURL + path.value
    }
    
    func decode(_ data: Data) throws -> ResponseData {
        let decoder = JSONDecoder()
        
        return try decoder.decode(ResponseData.self, from: data)
    }
}
