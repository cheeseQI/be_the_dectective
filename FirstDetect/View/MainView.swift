//
//  MainView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ChatListView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Chats")
                }
            ClueView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Clues")
                }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
