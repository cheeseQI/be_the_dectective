//
//  Chat.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

class Chat: Identifiable, ObservableObject, Decodable {
    //let id = UUID()
    var username: String = ""
    @Published var lastMessageText: String = ""
    @Published var messages: [Message] = []
    
    init(){}
    
    enum CodingKeys : String, CodingKey {
        case username = "username"
        case lastMessageText = "lastMessageText"
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.lastMessageText = ""
        self.messages = []
    }
    
    init(username: String, lastMessageText: String, messages: [Message]) {
        self.username = username
        self.lastMessageText = lastMessageText
        self.messages = messages
    }
    
    func send(){
        
    }
    
    func recv(){
        
    }
}
