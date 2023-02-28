//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    
    private typealias MovieDetailPublisher = AnyPublisher<MovieDetailDataModel, RequestError>
    
    private let id: String?
    private let networkService: NetworkService
    private var cancellable: AnyCancellable?
    
    @Published private(set) var movie: MovieDetailDataModel?
    @Published var error: LocalizedError?
    
    init(networkService: NetworkService, id: String?) {
        self.networkService = networkService
        self.id = id
    }
    
    func requestMovies() {
        guard let id else { return }
        
        let request = MovieDetailRequest(id: id)
        let publisher: MovieDetailPublisher = networkService.request(request)
        
        cancellable = publisher
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] movie in
                guard let self else { return }
                
                self.movie = self.removedEmptyImages(data: movie)
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
