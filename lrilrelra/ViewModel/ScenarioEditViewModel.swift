//
//  ScenarioEditViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 22.09.2024.
//

import Foundation

import SwiftUI
import RealmSwift

//class ScenarioEditViewModel: ObservableObject {
//    @ObservedRealmObject var scenario: Scenario
//
//    @Published var title: String
//    @Published var author: String
//    @Published var releaseDate: Date
//    @Published var roles: [Role] = []
//    
//    private var realm: Realm
//
//    init(scenario: Scenario, realm: Realm = try! Realm()) {
//        _scenario = ObservedRealmObject(wrappedValue: scenario)
//        self.realm = realm
//        self.title = scenario.title
//        self.author = scenario.author
//        self.releaseDate = scenario.releaseDate
//        self.roles = Array(scenario.roles)
//    }
//
////    func saveChanges() {
////        print("Saving changes")
////        do {
////            print(title, author, roles)
////            try realm.write {
////                print("Wrote block")
////                scenario.title = title
////                scenario.author = author
////                scenario.roles.removeAll()
////                scenario.roles.append(objectsIn: roles)
////            }
//////            print(scenario)
////
////        } catch {
////            print("Failed to save changes: \(error.localizedDescription)")
////        }
////    }
//
//    func addRole() {
//        let newRole = Role()
//        newRole.name = "New Role"
//        newRole.aliases = ""
//        roles.append(newRole)
//    }
//
//    func removeRole(at index: IndexSet) {
//        roles.remove(atOffsets: index)
//    }
//}
