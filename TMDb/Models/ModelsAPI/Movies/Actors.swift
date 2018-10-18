//
//  Actors.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/18/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import ObjectMapper


public class Actors: Mappable{
    
    var castId : Int?
    var character : String?
    var creditId : String?
    var gender : Int?
    var id : Int?
    var name : String?
    var order : Int?
    var profilePath : String?

    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        castId <- map["cast_id"]
        character <- map["character"]
        creditId <- map["credit_id"]
        gender <- map["gender"]
        id <- map["id"]
        name <- map["name"]
        order <- map["order"]
        profilePath <- map["profile_path"]
        
    }
    
    
}
