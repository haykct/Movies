//
//  NetworkService.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.Response, Error>) -> Void)
}


class DefaultNetworkService: NetworkService {
    func request<Request>(_ request: Request,
                          completion: @escaping (Result<Request.Response, Error>) -> Void) where Request : DataRequest {
        AF.request(request.url).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let data = try request.decode(data!)
                    
                    completion(.success(data))
                } catch (let error) {
                    print(error)
//                    completion(nil, error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
