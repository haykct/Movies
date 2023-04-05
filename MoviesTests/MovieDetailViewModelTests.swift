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
@testable import Movies

final class MovieDetailViewModelTests: XCTestCase {
    
    //MARK: Private properties
    
    private var movieDetailViewModel: MovieDetailViewModel!
    private var cancellable: AnyCancellable?
    
    //MARK: Lifecycle methods
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let session = Session(configuration: configuration)
        let networkService = DefaultNetworkService(session: session)
        
        movieDetailViewModel = MovieDetailViewModel(networkService: networkService, id: "")
    }
    
    override func tearDown() {
        super.tearDown()
        
        movieDetailViewModel = nil
        cancellable = nil
        
        Mocker.removeAll()
    }

    //MARK: Test methods
    
    func testRequestMoviesNoPictureCase() {
        let request = MovieDetailRequest(id: "")
        let expectation = expectation(description: "After the request actor image should be nil")
        let jsonString = "{\"actorList\": [{\"id\": \"\", \"name\": \"\", \"image\": \"https://imdb-api.com/images/original/nopicture.jpg\"}]}"
        let mock = Mock(url: URL(string: request.url)!,
                        dataType: .json,
                        statusCode: 200,
                        data: [.get: Data(jsonString.utf8)])
        
        mock.register()
        movieDetailViewModel.requestMovies()
        
        cancellable = movieDetailViewModel.$movie.sink { movie in
            guard let movie else { return }
            
            if let actor = movie.actorList?.first {
                XCTAssertNil(actor.image)
            } else {
                XCTFail("ActorList is nil or empty")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testRequestMoviesSomePictureCase() {
        let request = MovieDetailRequest(id: "")
        let expectation = self.expectation(description: "After the request actor image should not be nil")
        let jsonString = "{\"actorList\": [{\"id\": \"\", \"name\": \"\", \"image\": \"https://imdb-api.com/images/original/somepicture.jpg\"}]}"
        let mock = Mock(url: URL(string: request.url)!,
                        dataType: .json,
                        statusCode: 200,
                        data: [.get: Data(jsonString.utf8)])
        
        mock.register()
        movieDetailViewModel.requestMovies()

        cancellable = movieDetailViewModel.$movie.sink { movie in
            guard let movie else { return }

            XCTAssertNotNil(movie.actorList?.first?.image)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
