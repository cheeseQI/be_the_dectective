//
//  Chat.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

class Chat: Identifiable, ObservableObject {
    let id = UUID()
    var username: String = ""
    @Published var lastMessageText: String = ""
    @Published var messages: [Message] = []
    
    init(){}
    
    init(username: String, lastMessageText: String, messages: [Message]) {
        self.username = username
        self.lastMessageText = lastMessageText
        self.messages = messages
    }
}
