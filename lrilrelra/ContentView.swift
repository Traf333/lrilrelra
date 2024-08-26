//
//  ContentView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData


enum AppScreen: Hashable, Identifiable, CaseIterable {
    case scenarios
    case library
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .scenarios:
            Label("Сценарии", systemImage: "list.bullet")
        case .library:
            Label("Библиотека", systemImage: "book")
        case .settings:
            Label("Настройки", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .scenarios:
            ScenariosView()
        case .library:
            LibraryView()
        case .settings:
            SettingsView()
        }
    }
    
}

private struct CurrentTabKey: EnvironmentKey {
    static let defaultValue: Binding<AppScreen> = .constant(.scenarios)
}

extension EnvironmentValues {
    var currentTab: Binding<AppScreen> {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
}

struct ContentView: View {
    @State private var selectedTab: AppScreen = .scenarios
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(AppScreen.allCases) {screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
        .environment(\.currentTab, $selectedTab)
        .environment(Router())
    }
}


#Preview {
    ContentView().modelContainer(for: Scenario.self).previewDisplayName("Tab bar visible").preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
