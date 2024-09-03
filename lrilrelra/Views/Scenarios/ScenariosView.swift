//
//  ScenariosView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData

enum AddFromSource: String, Identifiable {
    case library = "library"
    case file = "file"
    
    var id: String { self.rawValue }
}

struct ScenariosView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var scenarios: [Scenario]
    @State private var addNewScenario = false
    
    @State private var addFromSource: AddFromSource? = nil
    @State private var isPresentingAddModal = false
    @State private var newTitle = ""
    @State private var newAuthor = ""
    @State private var newActorsNumber = 1
    @State private var newContent = ""
    
    var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(scenarios) { item in
                    NavigationLink {
                        ScenarioDetailsView(scenario: item)
                     
                    } label: {
                        VStack(alignment: .leading, content: {
                            Text(item.title).font(.headline)
                            
                            if let author = item.author {
                                Text(author).font(.subheadline).foregroundStyle(.secondary)
                            }
                            HStack {
                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric))
                                
                                if item.roles.count > 0 {
                                    HStack {
                                        Text("\(item.roles.count)")
                                        Image(systemName: "person.2.fill")
                                    }
                                }
                                
                            }.font(.caption).foregroundColor(.gray)
                        }).padding(.vertical, 4)
                 
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { addNewScenario = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $addNewScenario) {
                VStack(spacing: 16.0) {
                    Button("Add From File") {
                        addFromSource = .file
                        addNewScenario = false
                       
                    }
                    Button("Add From Library") {
                        addFromSource = .library
                        addNewScenario = false

                    }
                }
                .font(.title)
                .presentationDetents([.height(200)])
            }
            .sheet(item: $addFromSource) { source in
                VStack {
                    if source == .library {
                        LibraryView()
                    } else if source == .file {
                        AddScenarioModalView(isPresented: $isPresentingAddModal, newTitle: $newTitle, newAuthor: $newAuthor,  newActorsNumber: $newActorsNumber, newContent: $newContent) {
                            // Submit button action
                            viewModel.addScenario(title: newTitle, author: newAuthor, content: newContent, actorsNumber: newActorsNumber)
                            addFromSource = nil
                        }
                    }
                }.presentationDragIndicator(.visible)
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(scenarios[index])
            }
        }
    }
}

#Preview {
    ScenariosView()
        .modelContainer(for: Scenario.self)
}
