//
//  InTheatresDataModel.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 04.12.22.
//

import Foundation

struct InTheatresDataModel: Decodable {
    var movies: [InTheatresMovie]
    
    enum CodingKeys: CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        movies = try container.decode([InTheatresMovie].self, forKey: .items)
    }
}

struct InTheatresMovie: Decodable {
    var id: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id, image
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
    }
}
