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

  func buildScenario() -> (Scenario, [Speech]) {
    var position = 0
    let newScenario = Scenario(
      id: UUID().uuidString,
      title: self.title,
      author: self.author ?? "",
      createdAt: Date()
    )

    let speeches = self.content.split(separator: "\n").map {
      position += 1
      let speech = Speech(
        id: UUID().uuidString,
        scenarioId: newScenario.id,
        content: String($0),
        position: position
      )
      return speech
    }

    return (newScenario, speeches)
  }

  func document() -> [String: Any] {
    return [
      "title": title,
      "content": content,
      "author": author ?? "",
      "actorsNumber": actorsNumber ?? 0,
    ]
  }
}
