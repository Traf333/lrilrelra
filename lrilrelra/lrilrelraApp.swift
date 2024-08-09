//
//  lrilrelraApp.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData



@main
struct lrilrelraApp: App {     
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Scenario.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        
    }
}
