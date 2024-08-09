//
//  ScenarioDetailsView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

struct ScenarioDetailsView: View {
    let scenario: Scenario
    var body: some View {
        VStack {
            Text(scenario.title).font(.largeTitle)
            Text("Item at \(scenario.timestamp, format: Date.FormatStyle(date: .numeric))")
        }.toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ScenarioDetailsView(scenario: Scenario(title: "Some", timestamp: Date()))
}
