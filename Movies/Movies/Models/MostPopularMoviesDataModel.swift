//
//  MostPopularMoviesDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 11.12.22.
//

import Foundation

struct MostPopularMoviesDataModel: Decodable, Response {
    var items: [PopularMovie]
    var errorMessage: String?
}

struct PopularMovie: Hashable, Decodable {
    var id: String
    var title: String
    var image: String
    var rating: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, rating = "imDbRating"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        rating = try container.decode(String.self, forKey: .rating)
    }
}
