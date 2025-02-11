//
//  ScenariosViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 11.01.2025.
//

import Combine
import DittoSwift
import Foundation

class ScenariosViewModel: ObservableObject {
  @Published var scenarios: [Scenario] = []

  private var observer: DittoStoreObserver?

  init() {
    do {
      observer = try DittoService.shared.ditto.store.registerObserver(
        query: "SELECT * FROM `scenarios`"
      ) { [weak self] result in
        self?.scenarios = result.items.compactMap { Scenario(value: $0.value) }
      }
      try DittoService.shared.ditto.sync.registerSubscription(query: "SELECT * FROM `scenarios`")
      try DittoService.shared.ditto.sync.registerSubscription(query: "SELECT * FROM `speeches`")
    } catch {
      print("ScenariosViewModel init error: \(error)")
    }
  }

  deinit {
    observer?.cancel()
  }

  func addScenario(_ scenario: Scenario, speeches: [Speech] = []) async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query: "INSERT INTO `scenarios` DOCUMENTS (:newScenario) ON ID CONFLICT DO UPDATE",
        arguments: ["newScenario": scenario.docDictionary()])

      let queryPlaceholders = speeches.enumerated().map { "(:speech\($0.offset))" }.joined(
        separator: ", ")
      let query = "INSERT INTO `speeches` DOCUMENTS \(queryPlaceholders) ON ID CONFLICT DO UPDATE"

      var arguments: [String: Any] = [:]
      for (index, speech) in speeches.enumerated() {
        arguments["speech\(index)"] = speech.docDictionary()
      }

      try await DittoService.shared.ditto.store.execute(
        query: query,
        arguments: arguments
      )

    } catch {
      print("addScenario Error: \(error)")
    }

  }

  func deleteScenario(_ scenario: Scenario) async {
    do {
      try await DittoService.shared.ditto.store.execute(
        query: "EVICT FROM `scenarios` WHERE _id == '\(scenario.id)'")
    } catch {
      print("deleteScenario Error: \(error)")
    }
  }

}
