//
//  main.swift
//  DeepLinkRecognizer
//
//  Created by Mediym on 10/11/20.
//

import Foundation
import DeepLinkRecognizer

let supportedDeepLinkTypes: [DeepLink.Type] = [
    SimpleDeepLink.self,
    ComplexDeepLink.self
]

var recognizer = DeepLinkRecognizer(deepLinkTypes: supportedDeepLinkTypes)

let simpleUrl = URL(string: "https://domain.com/mediym41/DeepLinkRecognizer?q=search%20query&param=12")!
let complexUrl = URL(string: "https://domain.com/category/124/food/12.5?query=apple&max_price=10&min_price=5#discount")!

let deepLinkType = recognizer.deepLink(matching: simpleUrl)

switch deepLinkType {
case let simpleDeepLink as SimpleDeepLink:
    print("== SimpleDeepLink ==")
    print("Repository: \(simpleDeepLink.repository)")
    print("Param: \(simpleDeepLink.param)")
    print("Query: \(simpleDeepLink.query ?? "nil")")
    print("====================")
    
case let complexDeepLink as ComplexDeepLink:
    print("== ComplexDeepLink ==")
    print("Category id: \(complexDeepLink.categoryId)")
    print("Alias: \(complexDeepLink.alias)")
    print("Double: \(complexDeepLink.double)")
    print("Query: \(complexDeepLink.query)")
    print("Is new:: \(complexDeepLink.isNew)")
    print("Max price \(complexDeepLink.maxPrice)")
    print("Min price: \(complexDeepLink.minPrice)")
    print("Fragment \(complexDeepLink.fragment)")
    print("=====================")
    
default:
    print("Unable to match url: \(complexUrl.absoluteURL)")
}


// ====== Extended version =======

// extended types
recognizer.deepLinkTypes = [
    CategoryDeepLink.self,
    LandingDeepLink.self,
]

let extendedUrl = URL(string: "https://prom.ua/category/food")!
let extendedDeepLink = recognizer.deepLink(matching: extendedUrl) as? ExtendedDeepLink

switch extendedDeepLink?.enumRepresentation {
case .category(let deepLink):
    print("== Category Deep Link ==")
    print("ID: \(deepLink.id)")
    print("====================")
    
case .landing(let deepLink):
    print("== Landing Deep Link ==")
    print("=====================")
    
default:
    print("Unable to match url: \(extendedUrl.absoluteURL)")
}
