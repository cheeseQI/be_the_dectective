//
//  Chat.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

class Chat: Identifiable, ObservableObject, Codable {
    //let id = UUID()
    var username: String = ""
    var background: String = ""
    @Published var lastMessageText: String = ""
    @Published var messages: [Message] = []
    
    init(){}
    
    enum CodingKeys : String, CodingKey {
        case username = "name"
        case lastMessageText = "lastMessageText"
        case background = "background"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.username, forKey: .username)
        try container.encode(self.lastMessageText, forKey: .lastMessageText)
    }
    
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.background = try container.decode(String.self, forKey: .background)
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
