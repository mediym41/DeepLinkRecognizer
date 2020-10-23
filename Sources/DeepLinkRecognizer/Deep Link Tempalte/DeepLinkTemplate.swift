//
//  DeepLinkTemplate.swift
//  Zakupki
//
//  Created by d.pashchenko on 8/6/19.
//  Copyright © 2019 evo.company. All rights reserved.
//

import Foundation

/// Adopted by a type whose values are matched and extracted from a URL.
public protocol DeepLink {
    /// Returns a template that describes how to match and extract values from a URL.
    static var template: DeepLinkTemplate { get }
    
    /// Returns a origin url
    var url: URL { get }
    
    /// Initializes a new instance with values extracted from a URL.
    /// - Parameter values: Data values from a URL, whose keys are the names specified in a `DeepLinkTemplate`.
    init(url: URL, values: DeepLinkValues)
}

/// Data values extracted from a URL by a deep link template.
public struct DeepLinkValues {
    /// Values in the URL's path, whose keys are the names specified in a deep link template.
    public let path: [String: Any]
    
    /// Values in the URL's query string, whose keys are the names specified in a deep link template.
    public let query: [String: Any]
    
    /// The URL's fragment (i.e. text following a # symbol), if available.
    public let fragment: String?
    
    public init(path: [String: Any], query: [String: Any], fragment: String?) {
        self.path = path
        self.query = query
        self.fragment = fragment
    }
}

/// Describes how to extract a deep link's values from a URL.
/// A template is considered to match a URL if all of its required values are found in the URL.
public struct DeepLinkTemplate {
    
    // MARK: - State
    
    /// A named value in a URL's query string.
    public enum QueryStringParameter {
        case requiredInt(named: String), optionalInt(named: String)
        case requiredBool(named: String), optionalBool(named: String)
        case requiredDouble(named: String), optionalDouble(named: String)
        case requiredString(named: String), optionalString(named: String)
        case requiredArrayInt(named: String), optionalArrayInt(named: String)
        case requiredArrayBool(named: String), optionalArrayBool(named: String)
        case requiredArrayDouble(named: String), optionalArrayDouble(named: String)
        case requiredArrayString(named: String), optionalArrayString(named: String)
    }
    
    /// A named value in a URL's path string.
    public enum PathPart {
        case int(_ label: String)
        case bool(_ label: String)
        case string(_ label: String)
        case double(_ label: String)
        case term(_ component: String)
        case any
    }
    
    public let pathParts: [PathPart]
    public let parameters: Set<QueryStringParameter>
    
    // MARK: - Public API
    public init(pathParts: [PathPart] = [], parameters: Set<QueryStringParameter> = []) {
        self.pathParts = pathParts
        self.parameters = parameters
    }
    
    /// A matching URL must include this constant string at the correct location in its path.
    public func term(_ component: String) -> DeepLinkTemplate {
        return appending(pathPart: .term(component))
    }
    
    /// A matching URL must include a string at the correct location in its path.
    /// - Parameter name: The key of this string in the `path` dictionary of `DeepLinkValues`.
    public func string(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .string(name))
    }
    
    /// A matching URL must include an integer at the correct location in its path.
    /// - Parameter name: The key of this integer in the `path` dictionary of `DeepLinkValues`.
    public func int(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .int(name))
    }
    
    /// A matching URL must include a double at the correct location in its path.
    /// - Parameter name: The key of this double in the `path` dictionary of `DeepLinkValues`.
    public func double(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .double(name))
    }
    
    /// A matching URL must include a boolean at the correct location in its path.
    /// - Parameter name: The key of this boolean in the `path` dictionary of `DeepLinkValues`.
    public func bool(named name: String) -> DeepLinkTemplate {
        return appending(pathPart: .bool(name))
    }
    
    /// A matching URL must include anything at the correct location in its path.
    public func any() -> DeepLinkTemplate {
        return appending(pathPart: .any)
    }
    
    /// An unordered set of query string parameters.
    /// - Parameter queryStringParameters: A set of parameters that may be required or optional.
    public func queryStringParameters(_ queryStringParameters: Set<QueryStringParameter>) -> DeepLinkTemplate {
        return DeepLinkTemplate(pathParts: pathParts, parameters: queryStringParameters)
    }
    
    // MARK: - Private creation methods
    
    private func appending(pathPart: PathPart) -> DeepLinkTemplate {
        return DeepLinkTemplate(pathParts: pathParts + [pathPart], parameters: parameters)
    }
    
}

// MARK: - Helpers

extension DeepLinkTemplate {
    
    var priority: UInt64 {
        
        guard self.pathParts.count < 20 else { // overflow
            return .max
        }
        
        var result: UInt64 = 0
        
        for pathPart in pathParts {
            
            result *= 10
            
            switch pathPart {
            case .any:
                result += 0
            case .string:
                result += 1
            case .double:
                result += 2
            case .int, .bool:
                result += 3
            case .term:
                result += 4
            }
        }
        
        return result
    }
    
}
