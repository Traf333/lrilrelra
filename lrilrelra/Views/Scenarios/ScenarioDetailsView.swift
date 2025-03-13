//
//  ScenarioDetailsView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

struct ScenarioDetailsView: View {
  var scenario: Scenario
  @StateObject private var viewModel: ScenarioDetailsViewModel

  init(scenario: Scenario) {
    self.scenario = scenario
    _viewModel = StateObject(wrappedValue: ScenarioDetailsViewModel(scenario: scenario))
  }

  @State var selectedRole: Role? = nil
  @State var current: [Speech] = []
  @State var showingList: Bool = false
  @State var selectedSpeech: Speech? = nil

  var body: some View {
    VStack(alignment: .leading) {
      ScrollViewReader { proxy in
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(viewModel.speeches) { speech in
              SpeechRowViewContainer(speech: speech)
            }
          }
        }.sheet(isPresented: $showingList) {
          BookmarksList(proxy: proxy)
        }
      }
      .toolbar {
        if let speech = selectedSpeech {
          ToolbarItemGroup(placement: .bottomBar) {
                      PlayerView(scenarioId: scenario.id, speechId: speech.id) { audio in
                          await viewModel.addAudio(speechId: speech.id, audioURL: audio)
                      }
          }
        }

        ToolbarItemGroup(placement: .navigationBarTrailing) {
          NavigationLink(
            destination: ScenarioEditView(viewModel: viewModel)
          ) {
            Image(systemName: "square.and.pencil")
          }
          Button(action: {
            withAnimation {
              showingList.toggle()
            }
          }) {
            Image(systemName: "list.bullet")
          }
        }
      }
      .navigationTitle(scenario.title)
    }
  }

  private func SpeechRowViewContainer(speech: Speech) -> some View {
    SpeechRowView(
      speech: speech,
      inBookmarks: viewModel.bookmarks.map { $0.id }.contains(speech.id),
      selected: speech.id == selectedSpeech?.id,
      onRoleSelect: selectRole,
      onDelete: {
        Task {
          await viewModel.deleteSpeech(speech: speech)
        }
      },
      toggleBookmark: viewModel.toggleBookmark,
      onUpdateSpeech: viewModel.updateSpeech
    )
    .id(speech.position)
    .opacity(getOpacity(speech.content))
    .onTapGesture {
      selectedSpeech = speech.id == selectedSpeech?.id ? nil : speech
    }
  }

  private func BookmarksList(proxy: ScrollViewProxy) -> some View {
    List {
      ForEach(viewModel.bookmarks) { speech in
        Button(action: {
          proxy.scrollTo(speech.position, anchor: .top)

          showingList.toggle()
        }) {
          Text(
            speech.content.count > 40
              ? speech.content.prefix(40) + "..." : speech.content
          )
          .foregroundColor(.primary)
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(PlainButtonStyle())
        .layoutPriority(1)
      }
    }
    .presentationDetents([.large])
    .presentationDragIndicator(.visible)
  }

  func getOpacity(_ content: String) -> Double {
    if let selectedRole = selectedRole {
      let allNames =
        [selectedRole.name]
        + selectedRole.aliases.split(separator: ",").map {
          $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }

      if allNames.contains(where: { name in content.hasPrefix(name) }) {
        return 1
      } else {
        return 0.5
      }
    } else {
      return 1
    }
  }

  func selectRole(_ content: String) {
    print("selectRole: \(content)")
    print("scenario roles: \(scenario.roles)")
    // Search through each role in the scenario's roles list
    //    for role in scenario.roles.values {
    //      // Check if the role name is a prefix of the content
    //      if content.starts(with: role.name) {
    //        selectedRole = role
    //        return
    //      }
    //
    //      // Split the role's aliases into an array by comma and check each alias
    //      let aliasesArray = role.aliases.split(separator: ",").map {
    //        $0.trimmingCharacters(in: .whitespacesAndNewlines)
    //      }
    //      print("aliasesArray: \(aliasesArray)")
    //      for alias in aliasesArray {
    //        if content.starts(with: alias) {
    //          selectedRole = role
    //          return
    //        }
    //      }
    //    }

    selectedRole = nil
  }

}

#Preview {
  NavigationStack {
    ScenarioDetailsView(scenario: Scenario.example())
  }
}
