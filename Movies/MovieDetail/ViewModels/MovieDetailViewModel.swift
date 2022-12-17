//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    private var id: String?
    private var networkService: NetworkService
    
    @Published var movie: MovieDetailDataModel?
    
    init(networkService: NetworkService, id: String?) {
        self.networkService = networkService
        self.id = id
    }
    
    func requestMosvie() {
        guard let id else { return }
        
        let request = MovieDetailRequest(id: id)
        
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.movie = self.removedEmptyImages(data: data)
            case .failure(let error):
                // Show error screen in detail
                print(error.localizedDescription)
            }
        }
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
