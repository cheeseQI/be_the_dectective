//
//  ChatListItemView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

import SwiftUI

struct ChatListItemView: View {
    @ObservedObject var chat: Chat

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)

            VStack(alignment: .leading) {
                Text(chat.username)
                    .font(.headline)
                Text(chat.lastMessageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 70)
    }
}


struct ChatListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListItemView(chat: Chat(username: "Fangze", lastMessageText: "Hello", messages: []))
    }
}
