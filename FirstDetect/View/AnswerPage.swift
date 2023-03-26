//
//  AnswerPage.swift
//  FirstDetect
//
//  Created by oliver xu on 3/26/23.
//

import SwiftUI

struct AnswerPage: View {
    let script: Script
    @State private var messageText: String = ""
    @State private var showSelectView = false
    var body: some View {
        VStack{
            ScrollView {
                Text(script.background)
                    .padding()
                Text("Your answer")
                Spacer()
                    .frame(height: 10.0)
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
                Spacer()
                    .frame(height: 100.0)
                Button(action: {
                    self.showSelectView = true
                    
                }, label: {
                    Text("End Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }
            .fullScreenCover(isPresented: $showSelectView, content: {
                SelectScriptView()
            })
        }
    }
    func sendMessage() {
        if !messageText.trimmingCharacters(in: .whitespaces).isEmpty {
            let message = Message(text: messageText, isSentByCurrentUser: true)
//            chat.lastMessageText = messageText
//            chat.messages.append(message)
            messageText = ""
//            chatdb.postChat(username: chat.username, lastMessageText: chat.lastMessageText){ result in
//                switch result {
//                case .success(let data):
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print("Encoded JSON:\n\(jsonString)")
//                    }
//                    print("Chat object successfully posted. Server response: \(data)")
//                case .failure(let error):
//                    print("Error posting chat object: \(error.localizedDescription)")
//                }
//            }
        }
    }
}

struct AnswerPage_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPage(script: Script(title: "Mumu", author: "Miumiu"))
    }
}
