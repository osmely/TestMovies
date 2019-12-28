//
//  MovieDetailsModel.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation

class GenreModel : Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    var id:Int!
    var name:String!
    
    required init(from decoder: Decoder) throws {
          let container     = try decoder.container(keyedBy: CodingKeys.self)
          id                = try container.decode(Int.self, forKey: .id)
          name              = try container.decode(String.self, forKey: .name)
    }
}

class MovieDetailsModel : MovieModel {
    
    private enum CodingKeys: String, CodingKey {
        case genres = "genres"
        case runtime
    }
    
    var genres  : [GenreModel]?
    var runtime : Int?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeIfPresent([GenreModel].self, forKey: .genres)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
    }
    
}
