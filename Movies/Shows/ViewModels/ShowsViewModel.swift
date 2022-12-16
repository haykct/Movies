//
//  ShowsViewModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 16.12.22.
//

import Foundation

class ShowsViewModel: ObservableObject {
    
    @Published var shows: [Show] = []
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func requestTop250Shows() {
        let request = ShowsRequest()

//        networkService.request(request) { [weak self] result in
//            guard let self else { return }
//
//            switch result {
//            case .success(let data):
//                self.shows = data.items
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        if let url = Bundle.main.url(forResource: "Shows", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try request.decode(data)
                self.shows = jsonData.items
            } catch {
                print("error:\(error)")
            }
        }
    }
}
