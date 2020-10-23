//
//  CategoryDeepLink.swift
//  
//
//  Created by Mediym on 10/19/20.
//

import Foundation
import DeepLinkRecognizer

struct CategoryDeepLink: ExtendedDeepLink {
    
    // https://prom.ua/category/food
    static var template: DeepLinkTemplate {
        return .init(pathParts: [
            .term("category"),
            .string("category_id")
        ])
    }
    
    let url: URL
    let id: String
    
    var enumRepresentation: PromDeepLink {
        return .category(self)
    }
    
    init(url: URL, values: DeepLinkValues) {
        self.url = url
        
        id = values.path["category_id"] as! String
    }
    
}
