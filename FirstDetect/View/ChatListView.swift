//
//  ChatListView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var chatdb : ChatDB


    var body: some View {
        NavigationView {
            List(chatdb.record) { chat in
                NavigationLink(destination: ChatView(chat: chat)) {
                    ChatListItemView(chat: chat)
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
