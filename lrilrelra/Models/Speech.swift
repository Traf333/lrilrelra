//
//  Speech.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import Foundation
import RealmSwift

class Speech: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var content: String = ""
    @Persisted var position: Int = 0
}

//
//struct SpeechMock {
//    static func instance() -> Speech {
//        let container = try! ModelContainer(for: Schema([Scenario.self, Speech.self])) // Use inMemory storage for previews
//        
//        // Add a sample scenario to the in-memory container for preview
//        let context = ModelContext(container)
//        
//        
//        // Fetch the first scenario from the context for preview
//        if let firstScenario = try? context.fetch(FetchDescriptor<Speech>()).first {
//          return firstScenario
//        } else {
//            return Speech(content: "some cpontent", position: 1 )
//        }
//    }
//}
