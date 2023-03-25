//
//  ChatDB.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

class ChatDB : ObservableObject{
    static let shared = ChatDB()
    @Published var record : [Chat]
    
    init(){
        self.record = [Chat]()
    }
    
    func getchats(){
        let url = URL(string: "https://ece564sp23.colab.duke.edu/entries/all")!
        let request = URLRequest(url: url)
//        let user = "fx33"
//        let password = "42e2be4f5d638fcc5627c4b115c2a89d7d7dd8c949f63b3929a68a3b69335e40"
//        let loginData = String(format: "%@:%@", user, password).data(using: .utf8)!
//        let base64LoginData = loginData.base64EncodedString()
//        request.addValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.downloadTask(with: request){
            loc, resp, err in
            let decoder = JSONDecoder()
            var chats = [Chat]()
            if let err = err{
                print("Error: \(err)")
//                if let _ = self.loadJSON(){
//                    print("Success")
//                }
//                else{
//                    print("Cannot find resources")
//                    DispatchQueue.main.async {
//                        self.records = self.loadCohort()
//                    }
//                    let _ = self.saveJSON()
//                }
            }
            else if let loc = loc, let d = try? Data(contentsOf: loc)
            {
                do {
                    let decoded = try decoder.decode([Chat].self, from: d)
                    chats = decoded
                    self.record = chats
//                    for chat in chats{
//                        DispatchQueue.main.async {
//                            if self.findPerson(dukeperson.netID) != nil{
//                                let _ = self.updatePerson_local(dukeperson)
//                            }
//                            else{
//                                let _ = self.addPerson(dukeperson)
//                            }
//                        }
//                    }
//                    let _ = self.saveJSON()
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }
}
