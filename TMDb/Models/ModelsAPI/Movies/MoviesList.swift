//
//  MoviesList.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import ObjectMapper


public class MoviesList: Mappable {
    
    var page : Int?
    var movies : [Movie]?
    var totalPages : Int?
    var totalResults : Int?
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        page <- map["page"]
        movies <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
        
    }
    
    
}
