//
//  ScenariosView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData

struct ScenariosView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var scenarios: [Scenario]
    @State private var showTabBar = true
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(scenarios) { item in
                    NavigationLink {
                        ScenarioDetailsView(scenario: item, showTabBar: $showTabBar).onAppear {
                            self.showTabBar = false
                        }.onDisappear {
                            self.showTabBar = true
                        }
                            
                     
                    } label: {
                        VStack(alignment: .leading, content: {
                            Text(item.title).font(.headline)
                            
                            if let author = item.author {
                                Text(author).font(.subheadline).foregroundStyle(.secondary)
                            }
                            HStack {
                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric))
                                
                                if item.actors.count > 0 {
                                    HStack {
                                        Text("\(item.actors.count)")
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
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Scenario(title: "Test", timestamp: Date(), plot: "", author: "Muzick", actors: [Actor(name: "Bob")])
            modelContext.insert(newItem)
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
        .modelContainer(for: Scenario.self, inMemory: true)
}
