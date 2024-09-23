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
    
    func buildScenario() -> Scenario {
        var position = 0
        let newScenario = Scenario()
        newScenario.title = self.title
        newScenario.releaseDate = Date()
        newScenario.source = "remote"
        newScenario.author = self.author ?? ""
//        newScenario.roles
        print("Start to build new scenario")
        let speeches = self.content.split(separator: "\n").map {
            position += 1
            let speech = Speech()
            speech.content = String($0)
            speech.position = position
            return speech
        }
        newScenario.speeches.append(objectsIn: speeches)
        print("New scenario")
        return newScenario
    }
}

