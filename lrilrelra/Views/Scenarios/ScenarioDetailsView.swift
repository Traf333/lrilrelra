//
//  ScenarioDetailsView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData

struct ScenarioDetailsView: View {
    var scenario: Scenario
    @Query private var speeches: [Speech]
    @Binding var showTabBar: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("Item at \(scenario.timestamp, format: Date.FormatStyle(date: .numeric))")
            
            List {
                ForEach(speeches) { speech in
                    VStack(alignment: .leading) {
                        Text("Position: \(speech.position)")
                        Text(speech.content)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: selectRole) {
                        Label("Add Speech", systemImage: "users")
                    }
                }
            }
        }.padding()
        .navigationTitle(scenario.title)
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
    }
    
    private func selectRole() {
        
    }
    
}

//
//#Preview {
//    ScenarioDetailsView(scenario: Scenario(title: "Some", timestamp: Date(), speeches:  []), showTabBar: Binding)
//}
