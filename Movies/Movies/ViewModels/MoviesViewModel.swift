//
//  InTheatresMoviesViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import Foundation

class MoviesViewModel {
    
    //MARK: private properties
    
    private let group = DispatchGroup()
    private var networkService: NetworkService
    private(set) var inTheatresMovies: Box<[InTheatresMovie]> = Box()
    private(set) var popularMovies: Box<[PopularMovie]> = Box()
    private(set) var allMovies: Box<(inTheatres: [InTheatresMovie], popular: [PopularMovie])> = Box()
    private(set) var error: Box<Error> = Box()
    
    //MARK: initializers
    
    init(withNetworkService service: NetworkService) {
        networkService = service
    }
    
    //MARK: public methods
    
    func requestInTheatresMovies() {
        let request = InTheatresMoviesRequest()
        
        group.enter()
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.inTheatresMovies.value = data.items
                self.group.leave()
                print(data.errorMessage)
            case .failure(let error):
                self.error.value = error
                print(error.localizedDescription)
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
                print(data.errorMessage)
            case .failure(let error):
                self.error.value = error
                print(error.localizedDescription)
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
