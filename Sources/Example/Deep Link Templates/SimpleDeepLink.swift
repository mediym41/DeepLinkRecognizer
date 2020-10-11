//
//  RepositoryDeepLink.swift
//  
//
//  Created by Mediym on 10/11/20.
//

import Foundation
import DeepLinkRecognizer

struct SimpleDeepLink: DeepLink {
    
    // https://domain.com/mediym41/DeepLinkRecognizer?q=search%20query&param=12
    static var template: DeepLinkTemplate {
        return .init(pathParts: [
            .term("mediym41"),
            .string("repository")
        ], parameters: [
            .optionalString(named: "q"),
            .requiredInt(named: "param")
        ])
    }
    
    let url: URL
    let repository: String
    let query: String?
    let param: Int
    
    init(url: URL, values: DeepLinkValues) {
        self.url = url
        
        repository = values.path["repository"] as! String
        query = values.query["q"] as? String
        param = values.query["param"] as! Int
    }
    
}
