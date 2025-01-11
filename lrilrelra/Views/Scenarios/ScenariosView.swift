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

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.scenarios) { scenario in
            
          VStack(alignment: .leading) {
            Text(scenario.title)
              .font(.headline)
              Text(scenario.id)
                  .font(.caption)
            Text("Author: \(scenario.author)")
              .font(.subheadline)
            Text("Created: \(scenario.createdAt.formatted(date: .abbreviated, time: .shortened))")
              .font(.caption)
          }
        }
        .onDelete { indexSet in
          indexSet.forEach { index in
            Task {
              await viewModel.deleteScenario(viewModel.scenarios[index])
            }
          }
        }
      }
      .navigationTitle("Scenarios")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: addScenario) {
            Image(systemName: "plus")
          }
        }
      }
    }
  }

  private func addScenario() {
    let newScenario = Scenario(
        id: UUID().uuidString,
      title: "Scenario (\(viewModel.scenarios.count + 1))",
      author: "New Author",
      createdAt: Date(),
      releaseDate: nil,
      source: "New Source",
      createdBy: "System"
    )
    Task {
      await viewModel.addScenario(newScenario)
    }
  }
  // // @State private var scenarios: [Scenario] = []
  // @State private var addNewScenario = false

  // @State private var addFromSource: AddFromSource? = nil
  // @State private var isPresentingAddModal = false
  // @State private var newTitle = ""
  // @State private var newAuthor = ""
  // @State private var newActorsNumber = 1
  // @State private var newContent = ""

  // var viewModel = LibraryViewModel()

  // var body: some View {
  //   NavigationStack {
  //     List {
  //       ForEach(viewModel.scenarios) { scenario in
  //         Text(scenario.title)
  //       }
  //     }
  //   List {
  //     ForEach(scenarios) { item in
  //       NavigationLink {
  //         ScenarioDetailsView(scenario: item)
  //       } label: {
  //         VStack(
  //           alignment: .leading,
  //           content: {
  //             Text(item.title).font(.headline)
  //             if !item.author.isEmpty {
  //               Text(item.author).font(.subheadline).foregroundStyle(.secondary)
  //             }
  //             HStack {
  //               Text(item.releaseDate, format: Date.FormatStyle(date: .numeric))

  //               if item.roles.count > 0 {
  //                 HStack {
  //                   Text("\(item.roles.count)")
  //                   Image(systemName: "person.2.fill")
  //                 }
  //               }

  //             }.font(.caption).foregroundColor(.gray)
  //           }
  //         ).padding(.vertical, 4)
  //       }
  //     }
  //     .onDelete(perform: deleteItems)
  //     Button(action: { addNewScenario = true }) {
  //       Label("Add Scenario", systemImage: "folder.badge.plus")
  //     }
  //   }
  //   .toolbar {
  //     if !scenarios.isEmpty {
  //       ToolbarItem(placement: .navigationBarTrailing) {
  //         EditButton()
  //       }
  //       ToolbarItem {
  //         Button(action: { addNewScenario = true }) {
  //           Label("Add Item", systemImage: "plus")
  //         }
  //       }
  //     }
  //   }
  //   .sheet(isPresented: $addNewScenario) {
  //     VStack(spacing: 16.0) {
  //       Button("Add From File", systemImage: "plus") {
  //         addFromSource = .file
  //         addNewScenario = false

  //       }
  //       Button("Add From Library", systemImage: "book.pages") {
  //         addFromSource = .library
  //         addNewScenario = false

  //       }
  //     }
  //     .font(.subheadline)
  //     .presentationDetents([.height(100)])
  //   }
  //   .sheet(item: $addFromSource) { source in
  //     VStack {
  //       if source == .library {
  //         LibraryView()
  //       } else if source == .file {
  //         AddScenarioModalView(
  //           isPresented: $isPresentingAddModal, newTitle: $newTitle,
  //           newAuthor: $newAuthor, newActorsNumber: $newActorsNumber,
  //           newContent: $newContent
  //         ) { newScenario, publishToLibrary in
  //           // Submit button action
  //           if publishToLibrary {
  //             viewModel.addScenario(newScenario)
  //           }
  //           let scenario = newScenario.buildScenario()
  //           $scenarios.append(scenario)

  //           addFromSource = nil
  //         }
  //       }
  //     }
  //     .presentationDragIndicator(.visible)

  //   }
  //   .overlay {
  //     if scenarios.isEmpty {
  //       ContentUnavailableView(
  //         label: {
  //           Label("No Scenarios", systemImage: "book.pages")
  //         },
  //         description: {
  //           Text("Try to upload or add scenario from *.txt file")
  //         },
  //         actions: {
  //           Button("Add Scenario") { addNewScenario = true }
  //         }
  //       ).offset(y: -60)
  //     }
  //   }
  //   }
  // }

  //   private func deleteItems(offsets: IndexSet) {
  //     withAnimation {
  //       $scenarios.remove(atOffsets: offsets)
  //     }
  //   }
}

#Preview {
  ScenariosView()

}
