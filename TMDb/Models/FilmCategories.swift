//
//  FilmCategories.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation

struct FilmCategories {
    
    var categoryName: String = ""
    var categoryImage: String = ""
    var engCategoryName: String = ""
    
    init(categoryName: String, categoryImage: String, engCategoryName: String) {
        self.categoryName = categoryName
        self.categoryImage = categoryImage
        self.engCategoryName = engCategoryName
    }
    
}
