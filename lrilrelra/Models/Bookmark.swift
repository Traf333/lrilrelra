//
//  Bookmark.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 07.12.2024.
//

import Foundation

struct Bookmark: Identifiable, Hashable, Equatable {
  var id: String
  var speechId: String
  var scenarioId: String

  init(id: String, speechId: String, scenarioId: String) {
    self.id = id
    self.speechId = speechId
    self.scenarioId = scenarioId
  }
}
