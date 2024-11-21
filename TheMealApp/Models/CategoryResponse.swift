//
//  CategoryResponse.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

 /*
{
  "categories": [
    {
      "idCategory": "1",
      "strCategory": "Beef",
      "strCategoryThumb": "https://www.themealdb.com/images/category/beef.png",
      "strCategoryDescription": "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"
    },
  ]
}
// */


public struct CategoryResponse: Codable {
    public var categories: [Category]
    
    public struct Category: Identifiable, Codable, Equatable {
        public var idCategory: String
        public var strCategory: String
        public var strCategoryThumb: String
        public var strCategoryDescription: String
        
        // Computed property para cumplir con el protocolo Identifiable
        public var id: String {
            return idCategory
        }
    }
}
