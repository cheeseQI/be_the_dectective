//
//  Chat.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

struct Chat: Identifiable {
    let id = UUID()
    let username: String
    let lastMessageText: String
}
