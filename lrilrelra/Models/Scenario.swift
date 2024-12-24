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
    @Persisted var bookmarkIds = RealmSwift.List<ObjectId>()
    
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
        
        scenario.roles.append(objectsIn: [role1, role2])
        scenario.speeches.append(objectsIn: Speech.examples(n: 200))
        
        
        return scenario
    }
}
