//
//  Backdrop.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/18/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import ObjectMapper


public class Backdrop: Mappable{
    
    var aspectRatio : Float?
    var filePath : String?
    var height : Int?
    var iso6391 : String?
    var voteAverage : Int?
    var voteCount : Int?
    var width : Int?
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        aspectRatio <- map["aspect_ratio"]
        filePath <- map["file_path"]
        height <- map["height"]
        iso6391 <- map["iso_639_1"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        width <- map["width"]

        
    }
    
    
}
