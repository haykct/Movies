//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Hayk Hayrapetyan on 17.12.22.
//

import XCTest

final class MoviesTests: XCTestCase {
    var viewModel: MovieDetailViewModel = MovieDetailViewModel(networkService: DefaultNetworkService(), id: "")

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

}
