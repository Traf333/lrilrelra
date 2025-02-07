//
//  Role.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 07.02.2025.
//

import DittoSwift
import Foundation

struct Role: Identifiable, Hashable, Equatable {
  var id: String
  var name: String
  var aliases: String
  var scenarioId: String
}

extension Role {
  func docDictionary() -> [String: Any?] {
    [
      "_id": id,
      "name": name,
      "aliases": aliases,
      "scenarioId": scenarioId,
    ]
  }
}

extension Role: DittoDecodable {
  init(value: [String: Any?]) {
    id = value["_id"] as? String ?? ""
    name = value["name"] as? String ?? ""
    aliases = value["aliases"] as? String ?? ""
    scenarioId = value["scenarioId"] as? String ?? ""
  }
}
