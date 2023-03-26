//
//  ChatDB.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

let postChaturl = "http://vcm-30653.vm.duke.edu:8080/game/start"
let postChosenScripturl = "http://vcm-30653.vm.duke.edu:8080/game/start"

class ChatDB : ObservableObject{
    static let shared = ChatDB()
    @Published var record : [Chat]
    
    init(){
        self.record = [Chat]()
    }
    
    func update(chats: [Chat]){
        self.record = chats
    }
    
    
    func postChosenScript(scriptname: String, completion: @escaping (Result<Data, Error>) -> Void) {
            let url = URL(string: postChosenScripturl)
            let encoder = JSONEncoder()
            let postMessage = ["uuid": GameInfo.id, "scriptName": scriptname]
            do {
                let chatData = try encoder.encode(postMessage)
                if let jsonString = String(data: chatData, encoding: .utf8) {
                    print("Encoded JSON:\n\(jsonString)")
                }
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = chatData
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                        completion(.failure(error))
                        return
                    }
                    
                    completion(.success(data))
                }
                
                task.resume()
                
            } catch let error {
                completion(.failure(error))
            }
    }
    
    func postChat(username: String, lastMessageText: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: postChaturl)
        let encoder = JSONEncoder()
        let postMessage = ["uuid": GameInfo.id, "npcName": username, "userInput": lastMessageText]
        do {
            let chatData = try encoder.encode(postMessage)
            if let jsonString = String(data: chatData, encoding: .utf8) {
                print("Encoded JSON:\n\(jsonString)")
            }
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = chatData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(.failure(error))
                    return
                }
                
                completion(.success(data))
            }
            
            task.resume()
            
        } catch let error {
            completion(.failure(error))
        }
    }
}
