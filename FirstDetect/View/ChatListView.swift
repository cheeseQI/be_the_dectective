//
//  ChatListView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct ChatListView: View {
    @State private var chats: [Chat] = [
        Chat(username: "Alice", lastMessageText: "Hey, how are you?"),
        Chat(username: "Bob", lastMessageText: "Let's meet tomorrow."),
        Chat(username: "Charlie", lastMessageText: "Did you finish the task?")
    ]


    var body: some View {
        NavigationView {
            List(chats) { chat in
                NavigationLink(destination: ChatView(chat: chat)) {
                    ChatListItemView(chat: chat)
                }
            }
            .navigationTitle("Chats")
        }
    }
}


struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
