//
//  InTheatresMoviesViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import Foundation

class MoviesViewModel {
    
    //MARK: private properties
    
    private var networkService: NetworkService
    private(set) var movies: Box<[InTheatresMovie]> = Box()
    private(set) var error: Box<Error> = Box()
    
    //MARK: initializers
    
    init(withNetworkService service: NetworkService) {
        networkService = service
    }
    
    //MARK: public methods
    
    func requestInTheatresMovies() {
        let request = InTheatresMoviesRequest()
        
        networkService.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                if data.errorMessage.isEmpty {
                    self.movies.value = data.items
                    
                    return
                }
                
                self.error.value = DataError.invalidData
                print(data.errorMessage)
            case .failure(let error):
                self.error.value = error
                print(error.localizedDescription)
            }
        }
    }
    
}
