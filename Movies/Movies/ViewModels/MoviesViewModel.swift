//
//  InTheatresMoviesViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import Foundation

final class MoviesViewModel {
    
    //MARK: public properties
    
    weak var coordinator: MoviesCoordinator?
    let allMovies: Box<(inTheatres: [InTheatresMovie], popular: [PopularMovie])> = Box()
    let error: Box<Error> = Box()
    
    //MARK: private properties
    
    private let group = DispatchGroup()
    private let networkService: NetworkService
    private let inTheatresMovies: Box<[InTheatresMovie]> = Box()
    private let popularMovies: Box<[PopularMovie]> = Box()
    
    //MARK: initializers
    
    init(withNetworkService service: NetworkService) {
        networkService = service
    }
    
    //MARK: public methods
    
    func openDetail(withIndexPath indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .inTheatres:
            coordinator?.openDetail(withID: inTheatresMovies.value?[indexPath.item].id)
        case .mostPopular:
            coordinator?.openDetail(withID: popularMovies.value?[indexPath.item].id)
        default: return
        }
    }
    
    func requestInTheatresMovies() {
        let request = InTheatresMoviesRequest()
        
        group.enter()
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.inTheatresMovies.value = data.items
                self.group.leave()
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func requestMostPopularMovies() {
        let request = MostPopularMoviesRequest()
        
        group.enter()
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.popularMovies.value = data.items
                self.group.leave()
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func requestAllMovies() {
        requestInTheatresMovies()
        requestMostPopularMovies()
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            
            self.allMovies.value = (inTheatres: self.inTheatresMovies.value!,
                                    popular: self.popularMovies.value!)
        }
    }
    
}
