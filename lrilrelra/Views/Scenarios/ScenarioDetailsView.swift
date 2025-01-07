////
////  ScenarioDetailsView.swift
////  lrilrelra
////
////  Created by Igor Trofimov on 09.08.2024.
////
//
//import RealmSwift
//import SwiftUI
//
//struct ScenarioDetailsView: View {
//  @ObservedRealmObject var scenario: Scenario
//
//  @State var selectedRole: Role? = nil
//  @State var current: [Speech] = []
//  @State var showingList: Bool = false
//  @State var selectedSpeech: Speech? = nil
//
//  var bookmarks: [Speech] {
//    scenario.speeches.filter { scenario.bookmarkIds.contains($0._id) }
//  }
//  var body: some View {
//
//    VStack(alignment: .leading) {
//      ScrollViewReader { proxy in
//        ScrollView {
//          LazyVStack(alignment: .leading, spacing: 0) {
//            ForEach(scenario.speeches) { speech in
//              SpeechRowView(
//                speech: speech,
//                inBookmarks: scenario.bookmarkIds.contains(speech._id),
//                selected: speech == selectedSpeech,
//                onRoleSelect: selectRole,
//                onDelete: { deleteSpeech(speech: speech) },
//                toggleBookmark: { toggleBookmark(speech: speech) }
//              )
//              .id(speech.position)
//              .opacity(getOpacity(speech.content))
//              .onTapGesture {
//                selectedSpeech = speech == selectedSpeech ? nil : speech
//              }
//            }
//          }
//
//        }.sheet(isPresented: $showingList) {
//          List {
//            ForEach(bookmarks) { speech in
//              Button(action: {
//                proxy.scrollTo(speech.position, anchor: .top)
//
//                showingList.toggle()
//              }) {
//                Text(
//                  speech.content.count > 40
//                    ? speech.content.prefix(40) + "..." : speech.content
//                )
//                .foregroundColor(.primary)
//                .frame(maxWidth: .infinity, alignment: .leading)
//              }
//              .buttonStyle(PlainButtonStyle())
//              .layoutPriority(1)
//            }
//          }
//          .presentationDetents([.large])
//          .presentationDragIndicator(.visible)
//        }
//      }
//    }
//    .toolbar {
//        if let speech = selectedSpeech {
//            ToolbarItemGroup(placement: .bottomBar) {
//              PlayerView(scenarioId: scenario._id, speechId: speech._id)
//            }
//        }
//        
//      ToolbarItemGroup(placement: .navigationBarTrailing) {
//        NavigationLink(destination: ScenarioEditView(scenario: scenario)) {
//          Image(systemName: "square.and.pencil")
//        }
//          Button(action: {
//            withAnimation {
//              showingList.toggle()
//            }
//          }) {
//            Image(systemName: "list.bullet")
//          }
//      }
//    }
//    .navigationTitle(scenario.title)
//  }
//
//  private func getOpacity(_ content: String) -> Double {
//    if let selectedRole = selectedRole {
//      let allNames =
//        [selectedRole.name]
//        + selectedRole.aliases.split(separator: ",").map {
//          $0.trimmingCharacters(in: .whitespacesAndNewlines)
//        }
//
//      if allNames.contains(where: { name in content.hasPrefix(name) }) {
//        return 1
//      } else {
//        return 0.5
//      }
//    } else {
//      return 1
//    }
//  }
//
//  func selectRole(_ content: String) {
//    // Search through each role in the scenario's roles list
//    for role in scenario.roles {
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
//
//      for alias in aliasesArray {
//        if content.starts(with: alias) {
//          selectedRole = role
//          return
//        }
//      }
//    }
//
//    // If no matching role is found, you can handle it here (e.g., set selectedRole to nil)
//    selectedRole = nil
//  }
//
//  private func deleteSpeech(speech: Speech) {
//    do {
//      if let index = scenario.speeches.index(of: speech) {
//        let realm = try! Realm()
//
//        try realm.write {
//          $scenario.speeches.remove(at: index)
//        }
//      }
//    } catch let error {
//      print(error.localizedDescription)
//    }
//  }
//
//  private func toggleBookmark(speech: Speech) {
//    do {
//      let realm = try! Realm()
//
//      try realm.write {
//        if scenario.bookmarkIds.contains(speech._id) {
//          $scenario.bookmarkIds.remove(at: scenario.bookmarkIds.index(of: speech._id)!)
//        } else {
//          $scenario.bookmarkIds.append(speech._id)
//        }
//      }
//    } catch let error {
//      print(error.localizedDescription)
//    }
//  }
//
//}
//
//#Preview {
//  NavigationStack {
//    ScenarioDetailsView(scenario: Scenario.example())
//  }
//}
