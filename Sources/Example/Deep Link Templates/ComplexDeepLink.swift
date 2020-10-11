//
//  ComplexDeepLink.swift
//  
//
//  Created by Mediym on 10/11/20.
//

import Foundation
import DeepLinkRecognizer

struct ComplexDeepLink: DeepLink {
    
    static var template: DeepLinkTemplate {
        return .init(pathParts: [
            .term("category"),
            .int("category_id"),
            .string("alias"),
            .double("double")
        ], parameters: [
            .requiredString(named: "query"),
            .optionalBool(named: "is_new"),
            .optionalInt(named: "max_price"),
            .optionalInt(named: "min_price")
        ])
    }
    
    let url: URL
    
    // path
    let categoryId: Int
    let alias: String
    let double: Double
    
    // query
    let query: String
    let isNew: Bool?
    let maxPrice: Int?
    let minPrice: Int?
    
    let fragment: String?
    
    init(url: URL, values: DeepLinkValues) {
        self.url = url
        
        categoryId = values.path["category_id"] as! Int
        alias = values.path["alias"] as! String
        double = values.path["double"] as! Double
        
        query = values.query["query"] as! String
        isNew = values.query["is_new"] as? Bool
        maxPrice = values.query["max_price"] as? Int
        minPrice = values.query["min_price"] as? Int
        
        fragment = values.fragment
    }
    
}

