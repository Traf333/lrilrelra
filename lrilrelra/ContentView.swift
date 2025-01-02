//
//  ContentView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI

struct ContentView: View {
    @ObserveInjection var inject
    var body: some View {
        Text("Hello, World!").padding()
        ScenariosView().enableInjection()
    }
}


#Preview {
    ContentView()
}
