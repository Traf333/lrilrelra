//
//  LibraryView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

struct LibraryView: View {

    @StateObject var viewModel: LibraryViewModel = LibraryViewModel()
    
    var body: some View {
        NavigationStack {
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
        }
    }
}

#Preview {
    LibraryView()
}
