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
  var releaseYear: Int
  var createdAt: Date
  var source: String?
  var createdBy: String?
}

extension Scenario {
  init(
    id: String,
    title: String,
    author: String,
    releaseYear: Int = 0,
    createdAt: Date? = nil,
    source: String? = nil,
    createdBy: String? = nil,
    roles: [String] = []
  ) {
    self.id = id
    self.title = title
    self.author = author
    self.createdAt = createdAt ?? Date()
    self.releaseYear = releaseYear
    self.source = source
    self.createdBy = createdBy
  }
}

extension Scenario {
  func docDictionary() -> [String: Any?] {
    [
      "_id": id,
      "title": title,
      "author": author,
      "createdAt": createdAt.description,
      "releaseYear": releaseYear,
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
    self.releaseYear = value["releaseYear"] as? Int ?? 0
    self.source = value["source"] as? String
    self.createdBy = value["createdBy"] as? String
  }
}

extension Scenario {
  static func example() -> Scenario {
    Scenario(
      id: "id",
      title: "title",
      author: "author",
      releaseYear: 2008,
      createdAt: Date(),
      source: "source",
      createdBy: "createdBy"
    )
  }
}
