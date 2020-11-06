//
//  File.swift
//  
//
//  Created by Дмитрий Пащенко on 05.11.2020.
//

import Foundation

/// Data values extracted from a URL by a deep link template.
public struct DeepLinkValues {
    /// Values in the URL's path, whose keys are the names specified in a deep link template.
    public let path: [String: DeepLinkParameter]
    
    /// Values in the URL's query string, whose keys are the names specified in a deep link template.
    public let query: [String: DeepLinkParameter]
    
    /// The URL's fragment (i.e. text following a # symbol), if available.
    public let fragment: String?
    
    public init(path: [String: DeepLinkParameter] = [:], query: [String: DeepLinkParameter] = [:], fragment: String? = nil) {
        self.path = path
        self.query = query
        self.fragment = fragment
    }
    
    // MARK: - Decode
    
    public func container<T: DeepLinkParameterKey>(keyedBy keyType: T.Type) -> ParametersContainer<T> {
        return ParametersContainer(values: self, keyedBy: keyType)
    }
}



