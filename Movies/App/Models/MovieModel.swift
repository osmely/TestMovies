//
//  MovieModel.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//


import Foundation
import ObjectMapper

class MovieModel : Mappable {
    
    var id                  :Int!
    var picture             :String?
    
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id                   <- map["id"]
        picture              <- map["picture"]
        
    }
    
}
