//
//  Router.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 26.08.2024.
//

import Foundation

@Observable
class Router {
    var scenarioRoutes: [ScenarioRoutes] = []
    var libraryRoutes: [LibraryRoutes] = []
}

enum ScenarioRoutes: Hashable {
    case list
    case show(Scenario)
}

enum LibraryRoutes: Hashable {
    case list
    case show(ScenarioRemote)
}
