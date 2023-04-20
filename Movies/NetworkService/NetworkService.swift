//
//  NetworkService.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation
import Alamofire
import Combine

enum RequestError: LocalizedError {
    case invalidData(description: String)
    case networkConnection(error: Error)
    case unknown(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidData(let description):
            return description
        case .networkConnection(let error), .unknown(let error):
            return error.localizedDescription
        }
    }
}

protocol NetworkService {
    func request<Response>(_ request: Request) -> AnyPublisher<Response, RequestError> where Response: Decodable & ErrorInformationProvider
}

final class DefaultNetworkService: NetworkService {
    
    private let session: Session
    
    init(session: Session = AF) {
        self.session = session
    }
    
    func request<Response>(_ request: Request) -> AnyPublisher<Response, RequestError> where Response: Decodable & ErrorInformationProvider {
        session
            .request(request.url)
            .validate()
            .publishDecodable(type: Response.self)
            .value()
            .tryMap { dataModel in
                if dataModel.errorMessage.isNilOrEmpty { return dataModel }
                
                throw RequestError.invalidData(description: dataModel.errorMessage!)
            }
            .mapError { (error: Error) -> RequestError in
                guard let afError = error.asAFError else {
                    return (error as? RequestError) ?? .unknown(error: error)
                }
                
                if let urlError = afError.underlyingError as? URLError,
                   urlError.code == .notConnectedToInternet {
                    return .networkConnection(error: error)
                }
                
                return .unknown(error: error)
            }
            .eraseToAnyPublisher()
    }
}
