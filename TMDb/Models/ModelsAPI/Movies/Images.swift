//
//  Images.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/18/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import ObjectMapper


public class Images: Mappable{
    
    var backdrops : [Backdrop]?
    var id : Int?
    var posters : [Backdrop]?

    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        backdrops <- map["backdrops"]
        id <- map["id"]
        posters <- map["posters"]
        
    }
    
    
}
