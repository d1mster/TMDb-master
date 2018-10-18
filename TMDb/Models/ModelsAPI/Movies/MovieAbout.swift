//
//  MovieAbout.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/18/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import ObjectMapper


public class MovieAbout: Mappable{
    
    var adult : Bool?
    var backdropPath : String?
    var belongsToCollection : AnyObject?
    var budget : Int?
    var genres : [Genre]?
    var homepage : String?
    var id : Int?
    var imdbId : String?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Float?
    var posterPath : String?
    var releaseDate : String?
    var revenue : Int?
    var runtime : Int?
    var status : String?
    var tagline : String?
    var title : String?
    var video : Bool?
    var voteAverage : Float?
    var voteCount : Int?
    
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        belongsToCollection <- map["belongs_to_collection"]
        budget <- map["budget"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        id <- map["id"]
        imdbId <- map["imdb_id"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        revenue <- map["revenue"]
        runtime <- map["runtime"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        
    }
    
    
}
