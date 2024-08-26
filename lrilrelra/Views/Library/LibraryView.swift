//
//  LibraryView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

struct LibraryView: View {
    @Environment(Router.self) private var router
    @StateObject var viewModel: LibraryViewModel = LibraryViewModel()
    @State private var isPresentingAddModal = false
    @State private var newTitle = ""
    @State private var newAuthor = ""
    @State private var newActorsNumber = 1
    @State private var newContent = ""
    //
    //    init(viewModel: LibraryViewModel = LibraryViewModel()) {
    //            _viewModel = StateObject(wrappedValue: viewModel)
    //        }
    //
    var body: some View {
        @Bindable var router = router
        
        
        NavigationStack(path: $router.libraryRoutes) {
            List(viewModel.scenarios, id: \.uniqID) { scenario in
                NavigationLink(destination: ScenarioRemoteView(viewModel: viewModel, scenario: scenario)) {
                    VStack(alignment: .leading) {
                        Text(scenario.title).font(.headline)
                        HStack {
                            if let author = scenario.author {
                                Text(author).font(.subheadline).foregroundStyle(.secondary)
                            }
                            
                            if let actorsNumber = scenario.actorsNumber, actorsNumber > 0 {
                                HStack {
                                    Text("\(actorsNumber)")
                                    Image(systemName: "person.2.fill")
                                }
                            }
                            
                        }.font(.caption).foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("")
            .navigationBarItems(trailing: Button("Add") {
                isPresentingAddModal = true
            })
            .sheet(isPresented: $isPresentingAddModal) {
                AddScenarioModalView(isPresented: $isPresentingAddModal, newTitle: $newTitle, newAuthor: $newAuthor,  newActorsNumber: $newActorsNumber, newContent: $newContent) {
                    // Submit button action
                    viewModel.addScenario(title: newTitle, author: newAuthor, content: newContent, actorsNumber: newActorsNumber)
                    isPresentingAddModal = false
                }
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(for: Scenario.self).previewDisplayName("Tab bar visible")
}
