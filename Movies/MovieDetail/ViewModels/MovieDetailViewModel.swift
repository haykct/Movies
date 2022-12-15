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
        
//        networkService.request(request) { [weak self] result in
//            guard let self else { return }
//
//            switch result {
//            case .success(let data):
//                self.movie = data
//            case .failure(let error):
////                self.error.value = error
//                print(error.localizedDescription)
//            }
//        }
        if let url = Bundle.main.url(forResource: "Detail", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try request.decode(data)
                self.movie = jsonData
            } catch {
                print("error:\(error)")
            }
        }
    }
}
