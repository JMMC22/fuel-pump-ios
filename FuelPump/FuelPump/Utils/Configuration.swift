//
//  Configuration.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import Foundation

enum Configuration {

    static func value<T>(for key: ConfigurationKey) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }

    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
}

enum ConfigurationKey: String {
    case apiBaseUrl = "API_BASE_URL"
}


