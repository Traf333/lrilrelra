//
//  Item.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//
import DittoSwift
import Foundation

struct Scenario: Identifiable, Hashable, Equatable {
  var id: String
  var title: String
  var author: String
  var createdAt: Date
  var releaseDate: Date?
  var source: String?
  var createdBy: String?
}

extension Scenario {
  init(
    id: String,
    title: String,
    author: String,
    createdAt: Date? = nil,
    releaseDate: Date? = nil,
    source: String? = nil,
    createdBy: String? = nil
  ) {
    self.id = id
    self.title = title
    self.author = author
    self.createdAt = createdAt ?? Date()
    self.releaseDate = releaseDate
    self.source = source
    self.createdBy = createdBy
  }
}

extension Scenario {
  func docDictionary() -> [String: Any?] {
    [
      "title": title,
      "author": author,
      "createdAt": createdAt,
      "releaseDate": releaseDate,
      "source": source,
      "createdBy": createdBy,
    ]
  }
}

extension Scenario: DittoDecodable {
  init(value: [String: Any?]) {
    self.id = value["_id"] as? String ?? ""
    self.title = value["title"] as? String ?? ""
    self.author = value["author"] as? String ?? ""
    self.createdAt = value["createdAt"] as? Date ?? Date()
    self.releaseDate = value["releaseDate"] as? Date
    self.source = value["source"] as? String
    self.createdBy = value["createdBy"] as? String
  }
}
