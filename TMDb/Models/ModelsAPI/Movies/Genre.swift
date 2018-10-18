//
//  Genre.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/18/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import ObjectMapper


public class Genre: Mappable{
    
    var id : Int?
    var name : String?

    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        
    }
    
    
}
