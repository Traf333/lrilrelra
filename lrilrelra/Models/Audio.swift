//
//  Audio.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 24.12.2024.
//

import DittoSwift
import Foundation

struct Audio: Identifiable {
  var id: String
  var scenarioId: String
  var speechId: String
  var audioData: [String: Any?]
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
    print("Audio init: \(value)")
    self.id = value["_id"] as? String ?? ""
    self.scenarioId = value["scenarioId"] as? String ?? ""
    self.speechId = value["speechId"] as? String ?? ""
    self.audioData = value["audioData"] as? [String: Any?] ?? [:]
    self.uploadedAt = value["uploadedAt"] as? Date ?? Date()
  }
}
