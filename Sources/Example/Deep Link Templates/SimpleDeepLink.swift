//
//  RepositoryDeepLink.swift
//  
//
//  Created by Mediym on 10/11/20.
//

import Foundation
import DeepLinkRecognizer

struct SimpleDeepLink: DeepLink {
    
    enum CodingKeys: String, DeepLinkParameterKey {
        case repository
        case query = "q"
        case param
    }
    
    // https://domain.com/mediym41/DeepLinkRecognizer?q=search%20query&param=12
    static var template: DeepLinkTemplate {
        return .init(pathParts: [
            .term("mediym41"),
            .string(CodingKeys.repository)
        ], parameters: [
            .optionalString(named: CodingKeys.query),
            .requiredInt(named: CodingKeys.param)
        ])
    }
    
    let url: URL
    let repository: String
    let query: String?
    let param: Int
    
    init?(url: URL, values: DeepLinkValues) {
        self.url = url
        
        // unsafe
//        repository = values.path["repository"] as! String
//        query = values.query["q"] as? String
//        param = values.query["param"] as! Int
        
        // OR
        
        // safe
        do {
            let container = values.container(keyedBy: CodingKeys.self)
            repository = try container.decodePathItem(String.self, forKey: .repository)
            query = try container.decodeQueryItem(String?.self, forKey: .query)
            param = try container.decodeQueryItem(Int.self, forKey: .param)
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
