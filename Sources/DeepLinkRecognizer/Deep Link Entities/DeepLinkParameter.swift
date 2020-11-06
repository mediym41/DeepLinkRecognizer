//
//  DeepLinkParameter.swift
//  
//
//  Created by Дмитрий Пащенко on 05.11.2020.
//

import Foundation

// MARK: - DeepLinkParameterKey

public protocol DeepLinkParameterKey {
    var stringValue: String { get }
}

extension String: DeepLinkParameterKey {
    public var stringValue: String {
        return self
    }
}

public extension RawRepresentable where Self: DeepLinkParameterKey, RawValue: DeepLinkParameterKey {
    var stringValue: String {
        return rawValue.stringValue
    }
}

// MARK: - DeepLinkParameter

public protocol DeepLinkParameter {}

extension Bool: DeepLinkParameter {}
extension Int: DeepLinkParameter {}
extension Double: DeepLinkParameter {}
extension String: DeepLinkParameter {}
extension Array: DeepLinkParameter where Element: DeepLinkParameter {}




