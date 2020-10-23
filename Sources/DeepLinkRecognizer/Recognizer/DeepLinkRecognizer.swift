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
        let result = candidates.max { lhs, rhs in
            return  rhs.type.template.isPriorityMore(than: lhs.type.template)
        }
        
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
        
        var requiredParameters: [DeepLinkTemplate.QueryStringParameter] = []
        var optionalParameters: [DeepLinkTemplate.QueryStringParameter] = []
        
        for parameter in template.parameters {
            if parameter.isRequired {
                requiredParameters.append(parameter)
            } else {
                optionalParameters.append(parameter)
            }
        }
                
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
    
    private typealias QueryMap = [String: [String]]
    private func createMap(of query: String) -> QueryMap {
        
        // Transforms "a=b&c=d" to [(a, b), (c, d)]
        let keyValuePairs = query
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .filter { $0.count == 2 }
        
        var queryMap = QueryMap()
        for pair in keyValuePairs {
            if queryMap[pair[0]] == nil {
                queryMap[pair[0]] = [pair[1]]
            } else {
                queryMap[pair[0]]?.append(pair[1])
            }
        }
        
        return queryMap
    }
        
    private func value(of parameter: DeepLinkTemplate.QueryStringParameter, in queryMap: QueryMap) -> Any? {
        guard let values: [String] = queryMap[parameter.name] else { return nil }
        
        switch parameter.type {
        case .int:
            return values.first.map { Int($0) } ?? nil
        case .bool:
            return values.first.map { Bool($0) } ?? nil
        case .double:
            return values.first.map { Double($0) } ?? nil
        case .string:
            return values.first?.removingPercentEncoding ?? ""
        case .arrayInt:
            return transform(array: values, to: Int.self)
        case .arrayBool:
            return transform(array: values, to: Bool.self)
        case .arrayDouble:
            return transform(array: values, to: Double.self)
        case .arrayString:
            return values.compactMap { $0.removingPercentEncoding }
        }
    }
    
    private func transform<T: LosslessStringConvertible>(array: [String], to type: T.Type) -> [T]? {
        let transformed = array.compactMap { item in
            return T(item)
        }
        
        return !transformed.isEmpty ? transformed : nil
    }
}
