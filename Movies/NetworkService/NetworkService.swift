//
//  NetworkService.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation
import Alamofire

enum DataError: Error {
    case invalidData(String)
}

protocol NetworkService {
    var session: Session { get }
    
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.ResponseData, Error>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    
    let session: Session
    
    init(session: Session = AF) {
        self.session = session
    }
    
    func request<Request>(_ request: Request,
                          completion: @escaping (Result<Request.ResponseData, Error>) -> Void) where Request: DataRequest {
        session.request(request.url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try request.decode(data)
                    
                    if decodedData.errorMessage.isNilOrEmpty {
                        completion(.success(decodedData))
                        
                        return
                    }
                    
                    completion(.failure(DataError.invalidData(decodedData.errorMessage!)))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
