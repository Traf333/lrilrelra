//
//  ContentView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import DittoSwift


//struct ContentView: View {
////    @ObserveInjection var inject
//    @State private var scenarios: [Scenario] = []
////    private var ditto: Ditto?
//    
//
//    
//    var body: some View {
//        
//        Text("Hello, World!").padding()
//        List {
//            ForEach(scenarios) { scenario in
//                Text(scenario.title)
//            }
//        }
//            
//        
////        ScenariosView().enableInjection()
//    }
//    
////    private func observeTodos() -> AnyPublisher<[Todo], Never> {
////        return ditto.store.registerObserver(
////            query: "SELECT * FROM todos WHERE isDeleted = :isDeleted",
////            arguments: ["isDeleted": false]) { results in
////        // Decode the results
////        }
////    }
//    
////    func addTodo(title: String) async {
////        let newTodo = Todo()
////        newTodo.title = "Neew title"
////        do {
////            try await ditto.store.execute(query: "INSERT INTO todos DOCUMENTS (:todo)",
////                                arguments: ["todo": newTodo])
////        } catch {
////            print("error from adding new todo")
////        }
////       
////    }
//}

struct ContentView: View {
    @State var counter = 0

    var body: some View {
        VStack {
            Text("Counter One is: \(counter)")
            Button("Increment Counter") {
                counter += 1
            }
        }.padding(.bottom)
        
        CounterTwoView()
    }
}

struct CounterTwoView: View {
    // Change between @ObservedObject and @StateObject
    @ObservedObject var viewModel = CounterTwoViewModel()

    var body: some View {
        VStack {
            Text("Counter Two is: \(viewModel.count)")
            Button("Increment Counter") {
                viewModel.incrementCounter()
            }
        }
    }
}

final class CounterTwoViewModel: ObservableObject {
    @Published var count = 0

    func incrementCounter() {
        count += 1
    }
}


#Preview {
    ContentView()
}
