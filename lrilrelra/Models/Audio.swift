//
//  Audio.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 24.12.2024.
//

import Foundation
import RealmSwift

class Audio: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var _id: ObjectId
  @Persisted var scenarioId: ObjectId
  @Persisted var speechId: ObjectId
  @Persisted var audioData: Data
  @Persisted var uploadedAt: Date
}
