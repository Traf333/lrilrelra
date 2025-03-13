//
//  Speech.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import DittoSwift
import Foundation

struct Speech: Identifiable {
  var id: String
  var scenarioId: String
  var content: String
  var position: Int
  var isBookmark: Bool = false
  var audioToken: [String: Any?]? = nil

  init(id: String, scenarioId: String, content: String, position: Int) {
    self.id = id
    self.scenarioId = scenarioId
    self.content = content
    self.position = position
  }
}

extension Speech {
  func docDictionary() -> [String: Any?] {
    [
      "_id": id,
      "content": content,
      "position": position,
      "scenarioId": scenarioId,
      "isBookmark": isBookmark,
    ]
  }
}

extension Speech: DittoDecodable {
  init(value: [String: Any?]) {
    self.id = value["_id"] as? String ?? UUID().uuidString
    self.scenarioId = value["scenarioId"] as? String ?? ""
    self.content = value["content"] as? String ?? ""
    self.position = value["position"] as? Int ?? 0
    self.isBookmark = value["isBookmark"] as? Bool ?? false
    self.audioToken = value["audioToken"] as? [String: Any?]
  }
}

extension Speech {
  static func examples(n: Int) -> [Speech] {
    guard let filePath = Bundle.main.path(forResource: "zov", ofType: "txt"),
      let fileContent = try? String(contentsOfFile: filePath, encoding: .utf8)
    else {
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
