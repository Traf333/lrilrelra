//
//  Configuration.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 01.01.2025.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
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
}

enum API {
    static var remoteLibraryURL: URL {
        return try! URL(string: Configuration.value(for: "REMOTE_LIBRARY_URL"))!
    }
    
    static var storageURL: URL {
        return try! URL(string: Configuration.value(for: "REALM_STORAGE_URL"))!
    }
}
