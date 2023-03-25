//
//  Script.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import Foundation
struct Script: Identifiable {
    let id = UUID()
    let title: String
    let info: String
    let background: String
    
    init(title: String, info: String) {
        self.title = title
        self.info = info
        self.background = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}
