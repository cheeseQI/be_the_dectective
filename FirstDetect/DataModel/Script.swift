//
//  Script.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import Foundation
import SwiftUI
class Script: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let author: String
    let background: String
    var chats : [Chat] = []
    var target : String = ""
//    var picture: String = ""
    
//    var img: Image {
//        guard let imgData = Data(base64Encoded: self.picture, options: .ignoreUnknownCharacters),
//              let uiImage = UIImage(data: imgData)
//        else { return Image("error") }
//        return Image(uiImage: uiImage)
//    }
    
    enum CodingKeys : String, CodingKey {
        case title = "name"
        case author = "author"
        case background = "background"
        case npcs = "NPCInfos"
        case target = "target"
//        case picture = "scene"
        
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.background = try container.decode(String.self, forKey: .background)
        self.target = try container.decode(String.self, forKey: .target)
//        self.picture = try container.decode(String.self, forKey: .picture)
        chats = try container.decode([Chat].self, forKey: .npcs)
    }
    
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
        self.background = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    
    
}
