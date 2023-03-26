//
//  ScriptDB.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation
import SwiftUI
import Combine

class ScriptDB: ObservableObject{
    static var shared = ScriptDB()
    @Published var record : [Script]
    
    init(){
        self.record = [Script]()
    }
    
    func fetchAndUpdateData(urlString: String) {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
//                        print(String(data: data, encoding: .utf8))
//                        print(response)
                        let decodedResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
//                        print(decodedResponse)
                        DispatchQueue.main.async {
                            self.record = decodedResponse.scripts
                            GameInfo.id = decodedResponse.uid
                        }
                    } catch {
                        print("Decoding failed: \(error)")
                    }
                } else {
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
}

struct ServerResponse: Decodable {
    let scripts: [Script]
    let uid: String

    enum CodingKeys: String, CodingKey {
        case scripts = "script_list"
        case uid = "uuid"
    }
}
