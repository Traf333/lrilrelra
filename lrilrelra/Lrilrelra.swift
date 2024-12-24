//
//  lrilrelraApp.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import RealmSwift

@_exported import Inject

@main
struct Lrilrelra: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, Realm.Configuration(schemaVersion: 8))
            
        }
    }
}
