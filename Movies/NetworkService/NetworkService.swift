//
//  NetworkService.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation
import Alamofire

#warning("Remove")
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

enum DataError: Error {
    case invalidData
}

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.ResponseData, Error>) -> Void)
}

#warning("Restore request code")
class DefaultNetworkService: NetworkService {
    func request<Request>(_ request: Request,
                          completion: @escaping (Result<Request.ResponseData, Error>) -> Void) where Request: DataRequest {
//        AF.request(request.url).validate().responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
////                    debugPrint(data.prettyPrintedJSONString)
//                    let decodedData = try request.decode(data)
//
//                    if decodedData.errorMessage.isEmpty {
//                        completion(.success(decodedData))
//
//                        return
//                    }
//
//                    completion(.failure(DataError.invalidData))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
        
        if let url = Bundle.main.url(forResource: "InTheatres", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try request.decode(data)
                completion(.success(jsonData))
            } catch {
                print("error:\(error)")
            }
        }
        
    }

}
