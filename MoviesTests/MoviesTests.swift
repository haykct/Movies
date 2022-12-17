//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Hayk Hayrapetyan on 17.12.22.
//

import XCTest
import Mocker
import Alamofire

final class MoviesTests: XCTestCase {
    private var viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: "")

    func testEmtpyImageUrlReplace() {
        let request = MovieDetailRequest(id: "")
        var jsonString = "{\"actorList\": [{\"id\": \"\", \"name\": \"\", \"image\": \"https://imdb-api.com/images/original/nopicture.jpg\"}]}"
        var data = Data(jsonString.utf8)
        
        do {
            let dataModel = try request.decode(data)
            XCTAssertNotNil(dataModel.actorList?.first?.image)
            
            let removedImagesDataModel = viewModel.removedEmptyImages(data: dataModel)
            
            if let actor = removedImagesDataModel.actorList?.first {
                XCTAssertNil(actor.image)
            } else {
                XCTFail("ActorList is nil or empty")
            }
        } catch {
            XCTFail("Unable to decode the data")
        }
        
        jsonString = "{\"actorList\": [{\"id\": \"\", \"name\": \"\", \"image\": \"https://imdb-api.com/images/original/somepicture.jpg\"}]}"
        data = Data(jsonString.utf8)
        
        do {
            let dataModel = try request.decode(data)
            XCTAssertNotNil(dataModel.actorList?.first?.image)
            
            let removedImagesDataModel = viewModel.removedEmptyImages(data: dataModel)
            
            XCTAssertNotNil(removedImagesDataModel.actorList?.first?.image)
        } catch {
            XCTFail("Unable to decode the data")
        }
    }
    
    func testNetworkRequest() {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let session = Session(configuration: configuration)
        let networkService = DefaultNetworkService(session: session)
        let request = MostPopularMoviesRequest()
        
        testDecodeErrorCaseInRequest(request: request, networkService: networkService)
        testNullOrEmptyErrorCaseInRequest(request: request, networkService: networkService, errorMessage: "null")
        testNullOrEmptyErrorCaseInRequest(request: request, networkService: networkService, errorMessage: "\"\"")
        testNonEmptyErrorCaseInRequest(request: request, networkService: networkService)
    }
    
    func testDecodeErrorCaseInRequest(request: MostPopularMoviesRequest,
                                      networkService: DefaultNetworkService) {
        let successExpectation = expectation(description: "Request should fail")
        let jsonString = """
                {\"someOtherKey\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                \"errorMessage\": \"\"}
        """
        
        setupMock(jsonString: jsonString, url: request.url)
        networkService.request(request) { result in
            if case .success(_) = result {
                XCTFail("Request should have failed")
            }
            
            successExpectation.fulfill()
        }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    func testNullOrEmptyErrorCaseInRequest(request: MostPopularMoviesRequest,
                                           networkService: DefaultNetworkService,
                                           errorMessage: String) {
        let successExpectation = expectation(description: "Request should succeed")
        let jsonString = """
                {\"items\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                \"errorMessage\": \(errorMessage)}
        """
        
        setupMock(jsonString: jsonString, url: request.url)
        networkService.request(request) { result in
            if case .failure(_) = result {
                XCTFail("Request should have succeeded")
            }
            
            successExpectation.fulfill()
        }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    func testNonEmptyErrorCaseInRequest(request: MostPopularMoviesRequest,
                                        networkService: DefaultNetworkService) {
        let successExpectation = expectation(description: "Request should fail")
        let jsonString = """
                {\"items\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                \"errorMessage\": \"There is some error\"}
        """
        
        setupMock(jsonString: jsonString, url: request.url)
        networkService.request(request) { result in
            if case .success(_) = result {
                XCTFail("Request should have failed")
            }
            
            successExpectation.fulfill()
        }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    func setupMock(jsonString: String, url: String) {
        let mockedData = Data(jsonString.utf8)
        let mock = Mock(url: URL(string: url)!, dataType: .json, statusCode: 200, data: [.get: mockedData])
        
        mock.register()
    }

}
