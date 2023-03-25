//
//  ChatView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//
import SwiftUI

struct ChatView: View {
    @ObservedObject var chat: Chat
    @State private var messageText: String = ""
    @State private var messages: [Message] = [Message(text: "Hello", isSentByCurrentUser: false)]

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(chat.messages) { message in
                        MessageView(message: message)
                    }
                }.padding(.top)
            }

            HStack {
                TextField("enter message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                        .padding(.trailing)
                }
            }.padding()
        }
        .navigationTitle(chat.username)
        .navigationBarTitleDisplayMode(.inline)
        
    }

    func sendMessage() {
        if !messageText.trimmingCharacters(in: .whitespaces).isEmpty {
            let message = Message(text: messageText, isSentByCurrentUser: true)
            chat.lastMessageText = messageText
            chat.messages.append(message)
            messageText = ""
        }
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chat: Chat(username: "Fangze", lastMessageText: "Hello", messages: []))
    }
}
