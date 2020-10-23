//
//  File.swift
//  
//
//  Created by Mediym on 10/19/20.
//

import DeepLinkRecognizer

enum PromDeepLink {
    case category(CategoryDeepLink)
    case landing(LandingDeepLink)
}

protocol ExtendedDeepLink: DeepLink {
    var enumRepresentation: PromDeepLink { get }
}
