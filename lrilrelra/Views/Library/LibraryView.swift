//
//  LibraryView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var viewModel = LibraryViewModel()
    @State private var isPresentingAddModal = false
    @State private var newTitle = ""
    @State private var newActorsNumber = 1
    @State private var newContent = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.scenarios) { scenario in
                NavigationLink(destination: ScenarioRemoteView(viewModel: viewModel, scenario: scenario)) {
                    VStack(alignment: .leading) {
                        Text(scenario.title).font(.headline)
                        Text(scenario.content).font(.subheadline).lineLimit(2)
                    }
                }
            }
            .navigationTitle("Scenarios")
            .navigationBarItems(trailing: Button("Add") {
                isPresentingAddModal = true
            })
            .sheet(isPresented: $isPresentingAddModal) {
                AddScenarioModalView(isPresented: $isPresentingAddModal, newTitle: $newTitle, newActorsNumber: $newActorsNumber, newContent: $newContent) {
                    // Submit button action
                    viewModel.mockAddScenario(title: newTitle, content: newContent, actorsNumber: newActorsNumber)
                    isPresentingAddModal = false
                }
            }
        }
    }
}

#Preview {
    LibraryView()
}
