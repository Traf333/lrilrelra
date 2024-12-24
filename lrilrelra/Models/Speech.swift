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


extension Speech {
    static func examples(n: Int) -> [Speech] {
        guard let filePath = Bundle.main.path(forResource: "zov", ofType: "txt"),
              let fileContent = try? String(contentsOfFile: filePath) else {
            print("Error: Unable to read zov.txt")
            return []
        }
        
        let lines = fileContent.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        var speeches: [Speech] = []
        
        for i in 1...n {
            let content = lines[i]
            speeches.append(Speech(value: ["content": content, "position": i]))
        }
        
        return speeches
    }
}

