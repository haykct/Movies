//
//  NetworkServiceTests.swift
//  MoviesTests
//
//  Created by Hayk Hayrapetyan on 09.03.23.
//

import XCTest
import Mocker
import Alamofire
import Combine
@testable import Movies

final class NetworkServiceTests: XCTestCase {
    
    //MARK: Typealiases
    
    private typealias EmptyPublisher = Combine.Empty<MostPopularMoviesDataModel, Never>
    
    //MARK: Private properties
    
    private var networkService: NetworkService!
    private var cancellable: AnyCancellable?
    
    //MARK: Lifecycle methods
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let session = Session(configuration: configuration)

        networkService = DefaultNetworkService(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        
        networkService = nil
        cancellable = nil

        Mocker.removeAll()
    }
    
    //MARK: Test methods
    
    func testRequestNoConnectionCase() {
        let request = MostPopularMoviesRequest()
        let expectation = expectation(description: "Request should fail with networkConnection error")
        let mock = Mock(url: URL(string: request.url)!, dataType: .json, statusCode: 0,
                        data: [.get: Data()], requestError: URLError(.notConnectedToInternet))
        
        mock.register()
        
        cancellable = networkService.request(request)
            .catch { error in
                guard case .networkConnection(error: _) = error else {
                    XCTFail("Request should have failed with networkConnection error")
                    
                    return EmptyPublisher()
                }
                
                expectation.fulfill()
                
                return EmptyPublisher()
            }
            .sink { _ in XCTFail("Request should have failed with networkConnection error") }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testRequestNilAndEmptyStringErrorCase() {
        ["null", "\"\""].forEach { errorCase in
            let request = MostPopularMoviesRequest()
            let expectation = expectation(description: "Request should succeed")
            let jsonString = """
                    {\"items\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                    \"errorMessage\": \(errorCase)}
            """
            let mock = Mock(url: URL(string: request.url)!,
                            dataType: .json,
                            statusCode: 200,
                            data: [.get: Data(jsonString.utf8)])
            
            mock.register()
            
            cancellable = networkService.request(request)
                .catch { error in
                    XCTFail("Request should have succeeded")
                    
                    return EmptyPublisher()
                }
                .sink { _ in expectation.fulfill() }
            
            wait(for: [expectation], timeout: 3)
            Mocker.removeAll()
        }
    }
    
    func testRequestNonEmptyErrorCase() {
        let request = MostPopularMoviesRequest()
        let expectation = expectation(description: "Request should fail")
        let jsonString = """
                {\"items\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                \"errorMessage\": \"Some error\"}
        """
        let mock = Mock(url: URL(string: request.url)!,
                        dataType: .json,
                        statusCode: 200,
                        data: [.get: Data(jsonString.utf8)])
        
        mock.register()
        
        cancellable = networkService.request(request)
            .catch { error in
                guard case .invalidData(description: _) = error else {
                    XCTFail("Request should have failed with invalidData error")
                    
                    return EmptyPublisher()
                }
                
                expectation.fulfill()
                
                return EmptyPublisher()
            }
            .sink { _ in XCTFail("Request should have failed with invalidData error") }
        
        wait(for: [expectation], timeout: 3)
    }
}

