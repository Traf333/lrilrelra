//
//  ScenariosView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

enum AddFromSource: String, Identifiable {
  case library = "library"
  case file = "file"

  var id: String { self.rawValue }
}

struct ScenariosView: View {
  @StateObject private var viewModel = ScenariosViewModel()
  @State private var addNewScenario = false

  @State private var addFromSource: AddFromSource? = nil
  @State private var newTitle = ""
  @State private var newAuthor = ""
  @State private var newActorsNumber = 1
  @State private var newContent = ""
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.scenarios) { item in
          NavigationLink {
            ScenarioDetailsView(scenario: item)
          } label: {
            VStack(
              alignment: .leading,
              content: {
                Text(item.title).font(.headline)
                if !item.author.isEmpty {
                  Text(item.author).font(.subheadline).foregroundStyle(.secondary)
                }
                HStack {
                  if item.roles.count > 0 {
                    HStack {
                      Text("\(item.roles.count)")
                      Image(systemName: "person.2.fill")
                    }
                  }

                }.font(.caption).foregroundColor(.gray)
              }
            ).padding(.vertical, 4)
          }
        }
        .onDelete { indexSet in
          indexSet.forEach { index in
            Task {
              await viewModel.deleteScenario(viewModel.scenarios[index])
            }
          }
        }
        if !viewModel.scenarios.isEmpty {
          Button(action: { addNewScenario = true }) {
            Label("Add Scenario", systemImage: "folder.badge.plus")
          }
        }
      }
      .toolbar {
        if !viewModel.scenarios.isEmpty {
          ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
          }
          ToolbarItem {
            Button(action: { addNewScenario = true }) {
              Label("Add Item", systemImage: "plus")
            }
          }
        }
      }
      .sheet(isPresented: $addNewScenario) {
        VStack(spacing: 16.0) {
          Button("Add From File", systemImage: "plus") {
            addFromSource = .file
            addNewScenario = false

          }
          Button("Add From Library", systemImage: "book.pages") {
            addFromSource = .library
            addNewScenario = false

          }
        }
        .font(.subheadline)
        .presentationDetents([.height(100)])
      }
      .sheet(item: $addFromSource) { source in
        VStack {
          if source == .library {
            LibraryView()
          } else if source == .file {
            AddScenarioModalView(
              newTitle: $newTitle,
              newAuthor: $newAuthor, newActorsNumber: $newActorsNumber,
              newContent: $newContent,
              onCancel: {
                addFromSource = nil
              }
            ) { newScenario, publishToLibrary in
              // Submit button action
              if publishToLibrary {
                //                publish to lib
              }
              print("newScenario: \(newScenario)")
              let (scenario, speeches) = newScenario.buildScenario()
              Task {
                await viewModel.addScenario(scenario, speeches: speeches)
              }

              addFromSource = nil
            }
          }
        }
        .presentationDragIndicator(.visible)

      }
      .overlay {
        if viewModel.scenarios.isEmpty {
          ContentUnavailableView(
            label: {
              Label("No Scenarios", systemImage: "book.pages")
            },
            description: {
              Text("Try to upload or add scenario from *.txt file")
            },
            actions: {
              Button("Add Scenario") { addNewScenario = true }
            }
          ).offset(y: -60)
        }
      }
    }
  }
}

#Preview {
  ScenariosView()

}
