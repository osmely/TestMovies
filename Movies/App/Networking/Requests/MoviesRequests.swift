//
//  MoviesRequests.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation
import EasyNetRequest

// MARK: - GetMoviesRequest -
struct GetMoviesRequest : EasyNetRequest {
    typealias EasyNetResponseType = GetMoviewResult
    
    let page:Int
    
    func log(data: String) {
        print("\(data)")
    }
    
    var data: EasyNetRequestData {
        let request = EasyNetRequestData(
            path: NetworkingConstants.BASE_URL + "/movie/now_playing?api_key=\(NetworkingConstants.API_KEY)&page=\(page)",
            method: .GET
        )

        return request
    }
    
    var validators: [EasyNetResponseValidator]? { [] }
}

// MARK: - GetMovieDetailsRequest -
struct GetMovieDetailsRequest : EasyNetRequest {
    typealias EasyNetResponseType = MovieDetailsModel
    
    let id:Int
    
    func log(data: String) {
        Logger.log(message: data)
    }
    
    var data: EasyNetRequestData {
        let request = EasyNetRequestData(
            path: NetworkingConstants.BASE_URL + "/movie/\(id)?api_key=\(NetworkingConstants.API_KEY)",
            method: .GET
        )

        return request
    }
    
    var validators: [EasyNetResponseValidator]? { [] }
}
