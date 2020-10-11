//
//  DeepLinkRecognizer.swift
//  Zakupki
//
//  Created by d.pashchenko on 8/6/19.
//  Copyright © 2019 evo.company. All rights reserved.
//

import Foundation

extension URL {
    
    var isHttp: Bool {
        return scheme?.contains("http") ?? false
    }
    
}

/// Creates a deep link object that matches a URL.
public struct DeepLinkRecognizer {
    public var deepLinkTypes: [DeepLink.Type]
    
    /// Initializes a new recognizer with a list of available deep link types.
    /// - Parameter deepLinkTypes: An array of deep link types which can be created based on a URL.
    /// The template of each type is evaluated in the order the types appear in this array.
    public init(deepLinkTypes: [DeepLink.Type] = []) {
        self.deepLinkTypes = deepLinkTypes
    }
    
    public mutating func update(deepLinkTypes: [DeepLink.Type]) {
        self.deepLinkTypes = deepLinkTypes
    }
    
    /// Returns a new `DeepLink` object whose template matches the specified URL, if possible.
    public func deepLink(matching url: URL) -> DeepLink? {
        let components = makePathCommponents(url: url)
        var candidates: [(type: DeepLink.Type, value: DeepLinkValues)] = []
        
        for deepLinkType in deepLinkTypes {
            let template = deepLinkType.template
            guard let pathValues = extractPathValues(in: template, from: components) else { continue }
            guard let queryValues = extractQueryValues(in: template, from: url) else { continue }
            
            let values = DeepLinkValues(path: pathValues, query: queryValues, fragment: url.fragment)
            candidates.append((deepLinkType, values))
        }
        
        // fix collisions, get the most specific template
        let result = candidates.max(by: { $0.type.template.priority < $1.type.template.priority })
        
        return result.map { $0.type.init(url: url, values: $0.value) }
    }
    
    // MARK: - URL value extraction
    
    private func makePathCommponents(url: URL) -> [String] {
        var allComponents: [String] = []
        
        let shouldAddHost = url.scheme != nil && !url.isHttp
        if shouldAddHost, let firstComponent = url.host {
            allComponents.append(firstComponent)
        }
        
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        allComponents.append(contentsOf: pathComponents)
        
        return allComponents.compactMap { $0.removingPercentEncoding }
    }
    
    private func extractPathValues(in template: DeepLinkTemplate, from components: [String]) -> [String: Any]? {
        guard components.count == template.pathParts.count else { return nil }
        
        var values = [String: Any]()
        for (pathPart, component) in zip(template.pathParts, components) {
            switch pathPart {
            case .int(let label):
                guard let value = Int(component) else { return nil }
                values[label] = value
                
            case .bool(let label):
                guard let value = Bool(component) else { return nil }
                values[label] = value
                
            case .double(let label):
                guard let value = Double(component) else { return nil }
                values[label] = value
                
            case .string(let label):
                values[label] = component
                
            case .term(let pathPart):
                guard pathPart == component else { return nil }
                
            case .any:
                break
            }
        }
        
        return values
    }
    
    private func extractQueryValues(in template: DeepLinkTemplate, from url: URL) -> [String: Any]? {
        guard template.parameters.isEmpty == false else {
            return [:]
        }
        
        let requiredParameters = template.parameters.filter { $0.isRequired }
        let optionalParameters = template.parameters.subtracting(requiredParameters)
        
        guard let query = url.query else {
            return requiredParameters.isEmpty ? [:] : nil
        }
        
        let queryMap = createMap(of: query)
        var values = [String: Any]()
        
        for parameter in requiredParameters {
            guard let value = value(of: parameter, in: queryMap) else { return nil }
            values[parameter.name] = value
        }
        
        for parameter in optionalParameters {
            if let value = value(of: parameter, in: queryMap) {
                values[parameter.name] = value
            }
        }
        
        return values
    }
    
    private typealias QueryMap = [String: String]
    private func createMap(of query: String) -> QueryMap {
        
        // Transforms "a=b&c=d" to [(a, b), (c, d)]
        let keyValuePairs = query
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .filter { $0.count == 2 }
        
        var queryMap = QueryMap()
        for pair in keyValuePairs {
            queryMap[pair[0]] = pair[1]
        }
        
        return queryMap
    }
    
    private func value(of parameter: DeepLinkTemplate.QueryStringParameter, in queryMap: QueryMap) -> Any? {
        guard let value: String = queryMap[parameter.name] else { return nil }
        
        switch parameter.type {
        case .int:    return Int(value)
        case .bool:   return Bool(value)
        case .double: return Double(value)
        case .string: return value.removingPercentEncoding ?? ""
        }
    }
}

extension DeepLinkTemplate.QueryStringParameter: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(name)
    }
    
    public static func == (lhs: DeepLinkTemplate.QueryStringParameter, rhs: DeepLinkTemplate.QueryStringParameter) -> Bool {
        return lhs.name == rhs.name
    }
    
    fileprivate var name: String {
        switch self {
        case let .requiredInt(name):    return name
        case let .requiredBool(name):   return name
        case let .requiredDouble(name): return name
        case let .requiredString(name): return name
        case let .optionalInt(name):    return name
        case let .optionalBool(name):   return name
        case let .optionalDouble(name): return name
        case let .optionalString(name): return name
        }
    }
    
    fileprivate enum ParameterType { case string, int, double, bool }
    fileprivate var type: ParameterType {
        switch self {
        case .requiredInt, .optionalInt:       return .int
        case .requiredBool, .optionalBool:     return .bool
        case .requiredDouble, .optionalDouble: return .double
        case .requiredString, .optionalString: return .string
        }
    }
    
    fileprivate var isRequired: Bool {
        switch self {
        case .requiredInt, .requiredBool, .requiredDouble, .requiredString: return true
        case .optionalInt, .optionalBool, .optionalDouble, .optionalString: return false
        }
    }
}
