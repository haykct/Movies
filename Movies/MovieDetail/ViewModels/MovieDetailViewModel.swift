//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    
    private let id: String?
    private let networkService: NetworkService
    
    @Published private(set) var movie: MovieDetailDataModel?
    
    init(networkService: NetworkService, id: String?) {
        self.networkService = networkService
        self.id = id
    }
    
    func requestMovies() {
        guard let id else { return }
        
        let request = MovieDetailRequest(id: id)
        
//        networkService.request(request) { [weak self] result in
//            guard let self else { return }
//            
//            switch result {
//            case .success(let data):
//                self.movie = self.removedEmptyImages(data: data)
//            case .failure(let error):
//                // Show error screen in detail
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func removedEmptyImages(data: MovieDetailDataModel) -> MovieDetailDataModel {
        var newData = data
        
        newData.actorList = newData.actorList?.compactMap({ actor in
            if let image = actor.image, image.contains("nopicture") {
                var newActor = actor
                
                newActor.image = nil
                
                return newActor
            }
            
            return actor
        })
        
        return newData
    }
}
