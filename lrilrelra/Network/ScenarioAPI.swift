//
//  ScenarioAPI.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 13.08.2024.
//

import Foundation

class ScenarioAPI {
    static let shared = ScenarioAPI()
    
    private let baseURL = "https://myapi.com/scenarios"
    
    func fetchScenarios(completion: @escaping ([ScenarioRemote]?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let scenarios = try? JSONDecoder().decode([ScenarioRemote].self, from: data)
            completion(scenarios)
            
        }.resume()
    }
    
    func createScenario(scenario: ScenarioRemote, completion: @escaping (ScenarioRemote?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(scenario)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil)
            } else if let data = data {
                let record = try? JSONDecoder().decode(ScenarioRemote.self, from: data)
                completion(record)
            }
        }.resume()
    }
    
    func deleteScenario(id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
