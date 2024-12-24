import SwiftUI
import RealmSwift

class ScenarioViewModel: ObservableObject {
    @Published var scenario: Scenario

    init(scenario: Scenario) {
        self.scenario = scenario
    }
    
    private var cachedBookmarks: [Speech] = []

    func bookmarks() -> [Speech] {
        if cachedBookmarks.isEmpty {
            cachedBookmarks = scenario.speeches.filter { scenario.bookmarkIds.contains($0._id) }
        }
        return cachedBookmarks
    }

    func addBookmark(_ speech: Speech) {
        if !scenario.bookmarkIds.contains(speech._id) {
            scenario.bookmarkIds.append(speech._id)
            cachedBookmarks.append(speech)
        }
    }

    func removeBookmark(_ speech: Speech) {
        if let index = scenario.bookmarkIds.firstIndex(of: speech._id) {
            scenario.bookmarkIds.remove(at: index)
            cachedBookmarks.removeAll { $0._id == speech._id }
        }
    }

    func toggleBookmark(speech: Speech) {
        do {
            let realm = try Realm()
            try realm.write {
                if scenario.bookmarkIds.contains(speech._id) {
                    // Remove bookmark if it exists
                    removeBookmark(speech)
                    print("Removed bookmark for speech: \(speech.content)")
                } else {
                    // Add bookmark if it doesn't exist
                    addBookmark(speech)
                    print("Added bookmark for speech: \(speech.content)")
                }
            }
        } catch {
            print("Error toggling bookmark: \(error.localizedDescription)")
        }
    }
    
    
    func deleteSpeech(speech: Speech) {
        do {
            if let index = scenario.speeches.index(of: speech) {
                let realm = try! Realm()
                
                try realm.write {
                    // Remove the speech from the list
                    print("start")
                    // Optionally, delete the speech object from the Realm entirely
                    scenario.speeches.remove(at: index)
                    print("mid")
                    
                    print("end")
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
