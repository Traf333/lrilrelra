//
//  Audio.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 24.12.2024.
//

import Foundation

struct Audio: Identifiable, Hashable, Equatable {
  var id: String
  var scenarioId: String
  var speechId: String
  var audioData: Data?
  var uploadedAt: Date
}

extension Audio {
  func docDictionary() -> [String: Any?] {
    [
      "scenarioId": scenarioId,
      "speechId": speechId,
      "audioData": audioData,
      "uploadedAt": uploadedAt,
    ]
  }
}

extension Audio: DittoDecodable {
  init(value: [String: Any?]) {
    self.id = value["_id"] as? String ?? ""
    self.scenarioId = value["scenarioId"] as? String ?? ""
    self.speechId = value["speechId"] as? String ?? ""
    self.audioData = value["audioData"] as? Data ?? Data()
    self.uploadedAt = value["uploadedAt"] as? Date ?? Date()
  }
}
