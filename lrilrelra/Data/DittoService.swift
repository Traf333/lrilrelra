//
//  DittoService.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 03.01.2025.
//

import DittoSwift
import Foundation

typealias DittoQuery = (string: String, args: [String: Any?])

protocol DittoDecodable {
  init(value: [String: Any?])
}

class DittoService {
  static let shared = DittoService()

  let ditto: Ditto

  init() {
    ditto = Ditto(
      identity: .onlinePlayground(
        appID: "ef958315-0515-4b53-946b-0d55aedb9e57",
        token: "560daa69-8c8c-475c-a888-74fa8aadb314",
        enableDittoCloudSync: false  // Cloud sync is disabled
      )
    )

    // TODO: Maybe initialise some logging?

    do {
      // Disable sync with V3 Ditto
      try ditto.disableSyncWithV3()
      // Disable avoid_redundant_bluetooth
      Task {
        try await ditto.store.execute(
          query: "ALTER SYSTEM SET mesh_chooser_avoid_redundant_bluetooth = false"
        )
      }
    } catch let error {
      print("ERROR: disableSyncWithV3() failed with error \"\(error)\"")
    }

    // Prevent Xcode previews from syncing: non preview simulators and real devices can sync
    let isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    if !isPreview {
      try! ditto.startSync()
    }
  }
}
