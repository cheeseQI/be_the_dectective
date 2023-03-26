//
//  MainView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct MainView: View {
    let script: Script
    @State private var showSelectView = false
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
                AnswerPage(script: script)
                    .tabItem{
                        Image(systemName: "pencil")
                        Text("Answer")
                    }
                
            }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(script: Script(title: "Mumu", author: "Miumiu"))
    }
}
