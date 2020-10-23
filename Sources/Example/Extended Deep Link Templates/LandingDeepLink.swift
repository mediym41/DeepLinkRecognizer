//
//  LandingDeepLink.swift
//  
//
//  Created by Mediym on 10/19/20.
//

import Foundation
import DeepLinkRecognizer

struct LandingDeepLink: ExtendedDeepLink {
    
    // https://prom.ua/landing
    static var template: DeepLinkTemplate {
        return .init(pathParts: [
            .term("category"),
            .string("category_id")
        ])
    }
    
    let url: URL

    var enumRepresentation: PromDeepLink {
        return .landing(self)
    }
    
    init(url: URL, values: DeepLinkValues) {
        self.url = url
    }
    
}
