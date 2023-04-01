//
//  InTheatresMoviesViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import Foundation
import Combine

final class MoviesViewModel {
    
    //MARK: enums

    enum Section: Int, CaseIterable {
        case inTheatres
        case mostPopular
    }
    
    //MARK: type aliases
    
    typealias DataModels = (inTheatresMovies: [InTheatresMovie], mostPopularMovies: [PopularMovie])
    
    //MARK: public properties
    
    let allMovies = CurrentValueSubject<DataModels, RequestError>(([], []))

    //MARK: private properties
    
    private let networkService: NetworkService
    private var coordinator: MoviesCoordinator?
    private var cancellable: AnyCancellable?
    
    //MARK: initializers
    
    init(withNetworkService service: NetworkService, coordinator: MoviesCoordinator?) {
        self.networkService = service
        self.coordinator = coordinator
    }
    
    //MARK: public methods
    
    func openDetail(withIndexPath indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .inTheatres:
            coordinator?.openDetail(withID: allMovies.value.inTheatresMovies[indexPath.item].id)
        case .mostPopular:
            coordinator?.openDetail(withID: allMovies.value.mostPopularMovies[indexPath.item].id)
        default: return
        }
    }
    
    func requestAllMovies() {
        typealias InTheatresMoviesPublisher = AnyPublisher<InTheatresMoviesDataModel, RequestError>
        typealias MostPopularMoviesPublisher = AnyPublisher<MostPopularMoviesDataModel, RequestError>
        
        let inTheatresMoviesRequest = InTheatresMoviesRequest()
        let popularMoviesRequest = MostPopularMoviesRequest()
        let firstPublisher: InTheatresMoviesPublisher = networkService.request(inTheatresMoviesRequest)
        let secondPublisher: MostPopularMoviesPublisher = networkService.request(popularMoviesRequest)
        
        cancellable = firstPublisher
            .zip(secondPublisher)
            .map { ($0.0.items, $0.1.items) }
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.allMovies.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] allMovies in
                self?.allMovies.value = allMovies
            }
    }
}
