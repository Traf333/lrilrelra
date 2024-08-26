//
//  ScenarioAPI.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 13.08.2024.
//

import Foundation

class ScenarioAPI {
    static let shared = ScenarioAPI()
    
    private let baseURL = "https://lrilrelra-api.shuttleapp.rs/scenarios"
    
    func fetchScenarios(completion: @escaping ([ScenarioRemote]?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("error")
                completion(nil)
                return
            }
            print(data, "data")
            if let scenarios = try? JSONDecoder().decode([ScenarioRemote].self, from: data) {
                completion(scenarios)
            } else {
                print("some shit happened during fetch")
            }
        }.resume()
    }
    
    func createScenario(scenario: ScenarioRemote, completion: @escaping (ScenarioRemote?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(scenario)
        print("Creating scenario")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Error: \(String(describing: error))")
                completion(nil)
            } else if let data = data {
                let records = try? JSONDecoder().decode([ScenarioRemote].self, from: data)
                if let record = records?.first {
                    print("created record \(String(describing: record))")
                    completion(record)
                }
            }
        }.resume()
    }
    
    func deleteScenario(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)") else { return }
        print("deleting URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("request processed")
            print("\(String(describing: data))")
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("delete succeed")
                completion(true)
            } else {
                print("delete fails")
                completion(false)
            }
        }.resume()
    }
}
