//
//  File.swift
//  
//
//  Created by Дмитрий Пащенко on 05.11.2020.
//

import Foundation

public final class ParametersContainer<Key: DeepLinkParameterKey> {

    let values: DeepLinkValues
    
    init(values: DeepLinkValues, keyedBy keyType: Key.Type) {
        self.values = values
    }
    
    // MARK: Path
    
    public func decodePathItem<T: DeepLinkParameter>(_ type: T.Type, forKey key: Key) throws -> T {
        return try decodeItem(type, forKey: key.stringValue, in: values.path)
    }
    
    // MARK: Query
    
    public func decodeQueryItem<T: DeepLinkParameter>(_ type: T.Type, forKey key: Key) throws -> T {
        return try decodeItem(type, forKey: key.stringValue, in: values.query)
    }
    
    public func decodeQueryItem<T: DeepLinkParameter>(_ type: T?.Type, forKey key: Key) throws -> T? {
        return try decodeItem(type, forKey: key.stringValue, in: values.query)
    }
    
    // MARK: - Private
    
    private func decodeItem<T: DeepLinkParameter>(_ type: T.Type, forKey key: String, in source: [String: DeepLinkParameter]) throws -> T {
        guard let parameter = source[key] else {
            throw ParametersDecodingError.notFoundKey(key)
        }
        
        guard let value = parameter as? T else {
            let actualType = Swift.type(of: parameter)
            throw ParametersDecodingError.typecastFailed(key: key,
                                                         actual: String(describing: actualType),
                                                         expected: String(describing: type))
        }
        
        return value
    }
    
    private func decodeItem<T: DeepLinkParameter>(_ type: T?.Type, forKey key: String, in source: [String: DeepLinkParameter]) throws -> T? {
        guard let parameter = source[key] else {
            return nil
        }
        
        guard let value = parameter as? T else {
            let actualType = Swift.type(of: parameter)
            throw ParametersDecodingError.typecastFailed(key: key,
                                                         actual: String(describing: actualType),
                                                         expected: String(describing: type))
        }
        
        return value
    }
    
}
