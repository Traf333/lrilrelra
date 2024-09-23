//
//  ScenarioDetailsView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import RealmSwift

struct ScenarioDetailsView: View {
    @AppStorage("lastSpeechId") private var lastSpeechId: Int?
    @ObservedRealmObject var scenario: Scenario
    
    @State var selectedRole: Role? = nil
    @State var current: [Speech] = []
    
    
    // Timer to periodically save the first visible speech ID
    let saveInterval = 10.0 // Time interval in seconds
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(scenario.speeches) { speech in
                            SpeechRowView(speech: speech, onRoleSelect: selectRole, onDelete: {  deleteSpeech(speech: speech) })
                                .id(speech.id)
                                .opacity(getOpacity(speech.content))
                                .onAppear {
                                    current.append(speech)
                                    print(">> added \(speech.id)")
                                }
                                .onDisappear {
                                    current.removeAll { $0.id == speech.id }
                                    print("<< removed \(speech.id)")
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                //                .onAppear {
                ////                     Restore scroll to the last saved speech ID
                //                    if let lastSpeechId = lastSpeechId {
                //                        print("Restoring scroll to speech with ID: \(lastSpeechId)")
                //                        proxy.scrollTo(lastSpeechId, anchor: .top)
                //                    } else {
                //                        print("No saved speech ID found.")
                //                    }
                //
                //                    // Start the timer when the view appears
                //                    startTimer()
                //                }
                //                .onDisappear {
                //                    // Stop the timer when the view disappears
                //                    stopTimer()
                //                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ScenarioEditView(scenario: scenario)) {
                    Image(systemName: "square.and.pencil")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ScenarioEditView(scenario: scenario)) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .navigationTitle(scenario.title)
        
    }
    
    // Function to start the timer
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: saveInterval, repeats: true) { _ in
            saveFirstVisibleSpeech()
        }
    }
    
    // Function to stop the timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Function to save the first visible speech
    private func saveFirstVisibleSpeech() {
        if let firstVisibleSpeech = current.first {
            print("Saving first visible speech ID: \(firstVisibleSpeech.id)")
            lastSpeechId = Int(firstVisibleSpeech.id)
        } else {
            print("No visible speech to save.")
        }
    }
    
    private func getOpacity(_ content: String) -> Double {
        if let selectedRole = selectedRole {
            let allNames = [selectedRole.name] + selectedRole.aliases.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
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
        // Search through each role in the scenario's roles list
        for role in scenario.roles {
            // Check if the role name is a prefix of the content
            if content.starts(with: role.name) {
                selectedRole = role
                return
            }
            
            // Split the role's aliases into an array by comma and check each alias
            let aliasesArray = role.aliases.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
            for alias in aliasesArray {
                if content.starts(with: alias) {
                    selectedRole = role
                    return
                }
            }
        }
        
        // If no matching role is found, you can handle it here (e.g., set selectedRole to nil)
        selectedRole = nil
    }
    
    private func deleteSpeech(speech: Speech) {
        do {
            if let index = scenario.speeches.index(of: speech) {
                let realm = try! Realm()
                
                try realm.write {
                    // Remove the speech from the list
                    print("start")
                    // Optionally, delete the speech object from the Realm entirely
                    $scenario.speeches.remove(at: index)
                    print("mid")
                    
                    print("end")
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


#Preview {
    NavigationStack {
        ScenarioDetailsView(scenario: Scenario.example())
    }
}


