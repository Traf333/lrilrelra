//
//  ContentView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData


struct ContentView: View {

    var body: some View {
        TabView {
            ScenariosView()
               .tabItem {
                   Label("Scenarios", systemImage: "list.bullet")
               }

           LibraryView()
               .tabItem {
                   Label("Library", systemImage: "book")
               }

           SettingsView()
               .tabItem {
                   Label("Settings", systemImage: "gear")
               }
        }
               
    }
}

#Preview {
    
    ContentView().modelContainer(for: Scenario.self).previewDisplayName("Tab bar visible")
}
