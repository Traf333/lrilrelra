//
//  ScenarioDetailsViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 18.01.2025.
//

import DittoSwift
import SwiftUI

class ScenarioDetailsViewModel: ObservableObject {
  @Published var scenario: Scenario
  @Published var speeches: [Speech] = []
  @Published var bookmarks: [Speech] = []

  private var speechesObserver: DittoStoreObserver?
  private var bookmarksObserver: DittoStoreObserver?

  init(scenario: Scenario) {
    self.scenario = scenario
    print("Started scenario: \(scenario)")
    do {
      speechesObserver = try DittoService.shared.ditto.store.registerObserver(
        query: "SELECT * FROM `speeches` WHERE `scenarioId` = '\(scenario.id)' ORDER BY `position`"
      ) { [weak self] result in
        self?.speeches = result.items.compactMap { Speech(value: $0.value) }
      }
    } catch {
      print("ScenarioViewModel init error: \(error)")
    }

    do {
      bookmarksObserver = try DittoService.shared.ditto.store.registerObserver(
        query:
          "SELECT * FROM `speeches` WHERE `scenarioId` = '\(scenario.id)' AND `isBookmark` = true ORDER BY `position`"
      ) { [weak self] result in
        self?.bookmarks = result.items.compactMap { Speech(value: $0.value) }
      }
    } catch {
      print("ScenarioViewModel init error: \(error)")
    }
  }

  func save() async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query:
          "UPDATE `scenarios`SET title = :title, author = :author, releaseYear = :releaseYear WHERE `_id` = '\(scenario.id)'",
        arguments: [
          "title": scenario.title,
          "author": scenario.author,
          "releaseYear": scenario.releaseYear,
        ]
      )
    } catch {
      print("updateScenario Error: \(error)")
    }
    print("updateScenario done : \(scenario)")
  }

  func toggleBookmark(speech: Speech) async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query:
          "UPDATE `speeches` SET `isBookmark` = :isBookmark WHERE `_id` = :id",
        arguments: ["id": speech.id, "isBookmark": !speech.isBookmark]
      )
    } catch {
      print("Error updating speech: \(error.localizedDescription)")
    }
  }

  deinit {
    speechesObserver?.cancel()
    bookmarksObserver?.cancel()
  }

  func addSpeech(_ speech: Speech) async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query: "INSERT INTO `speeches` DOCUMENTS :newSpeech ON ID CONFLICT DO UPDATE",
        arguments: ["newSpeech": speech.docDictionary()]
      )
    } catch {
      print("Error adding speech: \(error.localizedDescription)")
    }
  }

  func updateSpeech(_ speech: Speech) async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query:
          "UPDATE `speeches` SET `content` = :content, `position` = :position WHERE `_id` = :id",
        arguments: ["id": speech.id, "content": speech.content, "position": speech.position]
      )
    } catch {
      print("Error updating speech: \(error.localizedDescription)")
    }
  }

  func deleteSpeech(speech: Speech) async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query: "EVICT FROM `speeches` WHERE `_id` = :id",
        arguments: ["id": speech.id]
      )
    } catch {
      print("Error deleting speech: \(error.localizedDescription)")
    }
  }
}
