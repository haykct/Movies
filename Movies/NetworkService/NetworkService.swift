//
//  NetworkService.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation
import Alamofire

enum RequestError: LocalizedError {
    case invalidData(description: String)
    case parseError(error: Error)
    case serverError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidData(let description):
            return description
        case .parseError(let error), .serverError(let error):
            return error.localizedDescription
        }
    }
}

protocol NetworkService {
    var session: Session { get }
    
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.ResponseData, RequestError>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    
    let session: Session
    
    init(session: Session = AF) {
        self.session = session
    }
    
    func request<Request>(_ request: Request,
                          completion: @escaping (Result<Request.ResponseData, RequestError>) -> Void) where Request: DataRequest {
        session.request(request.url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try request.decode(data)
                    
                    if decodedData.errorMessage.isNilOrEmpty {
                        completion(.success(decodedData))
                        
                        return
                    }
                    
                    completion(.failure(.invalidData(description: decodedData.errorMessage!)))
                } catch {
                    completion(.failure(.parseError(error: error)))
                }
            case .failure(let error):
                completion(.failure(.serverError(error: error)))
            }
        }
    }
}
