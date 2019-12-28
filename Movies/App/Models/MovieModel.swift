//
//  MovieModel.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//


import Foundation


class MovieModel : Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case vote_count
        case video
        case poster_path
        case adult
        case backdrop_path
        case original_language
        case original_title
        case genre_ids
        case title
        case vote_average
        case overview
        case release_date
    }
    
    var id                  :Int!
    var popularity          :Float?
    var vote_count          :Float?
    var video               :Bool?
    var poster_path         :String?
    var adult               :Bool?
    var backdrop_path       :String?
    var original_language   :String?
    var original_title      :String?
    var genre_ids           :[Int]?
    var title               :String?
    var vote_average        :Float?
    var overview            :String?
    var release_date        :String?
    
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        vote_count = try container.decodeIfPresent(Float.self, forKey: .vote_count)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
        original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
        genre_ids = try container.decodeIfPresent([Int].self, forKey: .genre_ids)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        vote_average = try container.decodeIfPresent(Float.self, forKey: .vote_average)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        
    }
    
    func posterPath(width:Int = 300) -> String? {
        guard let poster_path = self.poster_path else {return nil}
        return "https://image.tmdb.org/t/p/w\(width)/\(poster_path)"
    }
    
    func backdropPath(width:Int = 300) -> String? {
        guard let backdrop_path = self.backdrop_path else {return nil}
        return "https://image.tmdb.org/t/p/w\(width)/\(backdrop_path)"
    }
}


class GetMoviewResult : Codable {
    
    enum CodingKeys: String, CodingKey {
        case page
        case total_pages
        case total_results
        case results
    }
    
    var page                :Int!
    var total_pages         :Int!
    var total_results       :Int!
    var results             :[MovieModel]!
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        total_pages = try container.decode(Int.self, forKey: .total_pages)
        total_results = try container.decode(Int.self, forKey: .total_results)
        results = try container.decode([MovieModel].self, forKey: .results)
    
    }
}


