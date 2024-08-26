//
//  ScenarioRemote.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 13.08.2024.
//

import Foundation

struct ScenarioRemote: Codable, Hashable {
    struct ID: Codable, Hashable {
        let tb: String
        let id: IDValue
        
        struct IDValue: Codable, Hashable {
            let string: String
            
            // Coding keys to handle the unexpected case-sensitive key
            enum CodingKeys: String, CodingKey {
                case string = "String"
            }
        }
    }
    
    var id: ID?
    var title: String
    var content: String
    var author: String?
    var actorsNumber: Int?  // Make this optional if it is not always present
    var uniqID: String? {
        id?.id.string
    }
}

