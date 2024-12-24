//
//  Bookmark.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 07.12.2024.
//

import Foundation
import RealmSwift

class Bookmark: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var speechId: ObjectId
    @Persisted var schenarioId: ObjectId    
}
