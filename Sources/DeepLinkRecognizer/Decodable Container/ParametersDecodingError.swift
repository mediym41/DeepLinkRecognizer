//
//  ParametersDecodingError.swift
//  
//
//  Created by Дмитрий Пащенко on 05.11.2020.
//

import Foundation

public enum ParametersDecodingError: Error {
    case notFoundKey(String)
    case typecastFailed(key: String, actual: String, expected: String)
}

extension ParametersDecodingError: CustomStringConvertible, LocalizedError {
    public var description: String {
        switch self {
        case .notFoundKey(let key):
            return "Not found key: \(key)"
        case .typecastFailed(let key, let actual, let expected):
            return "Typecase failed for key: \(key), expect type: \(expected), actual type: \(actual)"
        }
    }
    
    public var errorDescription: String? {
        return description
    }
}

