//
//  Item.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import Foundation
import RealmSwift

class Role: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var aliases: String
}


class Scenario: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var releaseDate: Date
    @Persisted var source: String?
    
    @Persisted var roles = RealmSwift.List<Role>()
    @Persisted var speeches = RealmSwift.List<Speech>()
    
    static func example() -> Scenario {
        let scenario = Scenario()
        scenario.title = "Sample Scenario"
        scenario.author = "Sample Author"
        
        let role1 = Role()
        role1.name = "Role 1"
        role1.aliases = "Alias 1"
        
        let role2 = Role()
        role2.name = "Role 2"
        role2.aliases = "Alias 2"
        
        let speech1 = Speech()
        speech1.content = "Role 1. says something specific"
        speech1.position = 1
        
        let speech2 = Speech()
        speech2.content = "Role 2. responses to Role 1 with some big, long speech and some other details which might be relevent for the specific topic. In the other words ...."
        speech2.position = 2
        let speech3 = Speech()
        speech3.content = "Alias 1. says something specific on reply to Role 2"
        speech3.position = 3
        
        scenario.roles.append(objectsIn: [role1, role2])
        scenario.speeches.append(objectsIn: [speech2, speech1, speech3])
        
        return scenario
    }
}

//struct ScenarioMock {
//    static func instance() -> Scenario {
//        let container = try! ModelContainer(for: Schema([Scenario.self, Speech.self])) // Use inMemory storage for previews
//        
//        // Add a sample scenario to the in-memory container for preview
//        let context = ModelContext(container)
//        
//        
//        // Fetch the first scenario from the context for preview
//        if let firstScenario = try? context.fetch(FetchDescriptor<Scenario>()).first {
//          return firstScenario
//        } else {
//            return Scenario(title: "Example", releaseDate: Date(), roles: "Role 1, Role 2")
//        }
//    }
//}
