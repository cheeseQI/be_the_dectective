//
//  Message.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSentByCurrentUser: Bool
}

