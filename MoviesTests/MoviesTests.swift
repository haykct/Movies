//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Hayk Hayrapetyan on 17.12.22.
//

import XCTest
import Mocker
import Alamofire
import Combine

final class MoviesTests: XCTestCase {
    
    //MARK: Typealiases
    
    private typealias EmptyPublisher = Combine.Empty<MostPopularMoviesDataModel, Never>
    
    //MARK: Private properties
    
    private var viewModel: MovieDetailViewModel!
    private var cancellable: AnyCancellable?
    
    //MARK: Lifecycle methods
    
    override func setUp() {
        viewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: "")
    }
    
    override func tearDown() {
        viewModel = nil
        cancellable = nil
    }

    //MARK: Test methods
    
    func testEmtpyImageUrlReplace() {
        let decoder = JSONDecoder()
        var jsonString = "{\"actorList\": [{\"id\": \"\", \"name\": \"\", \"image\": \"https://imdb-api.com/images/original/nopicture.jpg\"}]}"
        var data = Data(jsonString.utf8)
        
        do {
            let dataModel = try decoder.decode(MovieDetailDataModel.self, from: data)
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
            let dataModel = try decoder.decode(MovieDetailDataModel.self, from: data)
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
        
        testConnectionIssueInRequest(request: request, networkService: networkService)
        testNullOrEmptyErrorCaseInRequest(request: request, networkService: networkService, errorMessage: "null")
        testNullOrEmptyErrorCaseInRequest(request: request, networkService: networkService, errorMessage: "\"\"")
        testNonEmptyErrorCaseInRequest(request: request, networkService: networkService)
    }
    
    //MARK: Private methods
    
    private func testConnectionIssueInRequest(request: MostPopularMoviesRequest,
                                      networkService: DefaultNetworkService) {
        let successExpectation = expectation(description: "Request should fail with networkConnection error")
        
        setupConnectionIssueMock(url: request.url)
        
        cancellable = networkService.request(request)
            .catch { error in
                guard case .networkConnection(error: _) = error else {
                    XCTFail("Request should have failed with networkConnection error")
                    
                    return EmptyPublisher()
                }
                
                successExpectation.fulfill()
                
                return EmptyPublisher()
            }
            .sink { _ in XCTFail("Request should have failed with networkConnection error") }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    private func testNullOrEmptyErrorCaseInRequest(request: MostPopularMoviesRequest,
                                           networkService: DefaultNetworkService,
                                           errorMessage: String) {
        let successExpectation = expectation(description: "Request should succeed")
        let jsonString = """
                {\"items\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                \"errorMessage\": \(errorMessage)}
        """
        
        setupMock(jsonString: jsonString, url: request.url)
        
        cancellable = networkService.request(request)
            .catch { error in
                XCTFail("Request should have succeeded")
                
                return EmptyPublisher()
            }
            .sink { _ in successExpectation.fulfill() }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    private func testNonEmptyErrorCaseInRequest(request: MostPopularMoviesRequest,
                                        networkService: DefaultNetworkService) {
        let successExpectation = expectation(description: "Request should fail")
        let jsonString = """
                {\"items\": [{\"id\": \"\", \"title\": \"\", \"image\": \"\", \"imDbRating\": \"\"}],
                \"errorMessage\": \"Some error\"}
        """
        
        setupMock(jsonString: jsonString, url: request.url)
        
        cancellable = networkService.request(request)
            .catch { error in
                guard case .invalidData(description: _) = error else {
                    XCTFail("Request should have failed with invalidData error")
                    
                    return EmptyPublisher()
                }
                
                successExpectation.fulfill()
                
                return EmptyPublisher()
            }
            .sink { _ in XCTFail("Request should have failed with invalidData error") }
        
        wait(for: [successExpectation], timeout: 3)
    }
    
    private func setupMock(jsonString: String, url: String) {
        let mockedData = Data(jsonString.utf8)
        let mock = Mock(url: URL(string: url)!, dataType: .json, statusCode: 200, data: [.get: mockedData])

        mock.register()
    }
    
    private func setupConnectionIssueMock(url: String) {
        let mock = Mock(url: URL(string: url)!, dataType: .json, statusCode: 0,
                        data: [.get: Data()], requestError: URLError(.notConnectedToInternet))
        
        mock.register()
    }

}
