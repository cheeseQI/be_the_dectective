//
//  ChatView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//
import SwiftUI

struct ChatView: View {
    @EnvironmentObject var chatdb: ChatDB
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
            chatdb.postChat(username: chat.username, lastMessageText: chat.lastMessageText){ result in
                switch result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Encoded JSON:\n\(jsonString)")
                    }
                    print("Chat object successfully posted. Server response: \(data)")
                case .failure(let error):
                    print("Error posting chat object: \(error.localizedDescription)")
                }
            }
        }
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        
        ChatView(chat: Chat(username: "Fangze", lastMessageText: "Hello", messages: []))
    }
}
