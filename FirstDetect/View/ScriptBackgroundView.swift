//
//  ScriptBackgroundView.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import SwiftUI

struct ScriptBackgroundView: View {
    let script: Script
    @State private var showMainView = false
    @StateObject var chatdb = ChatDB.shared
    
    var body: some View {
        VStack {
            ScrollView {
                Text(script.background)
                    .padding()
            }
            Spacer()
            Button(action: {
                showMainView = true
                chatdb.update(chats: script.chats)
                chatdb.postChosenScript(scriptname: script.title){ result in
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
            }, label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            })
            .padding(.bottom, 16)
        }
        .environmentObject(chatdb)
        .navigationTitle("\(script.title) background")
        .fullScreenCover(isPresented: $showMainView, content: {
            MainView()
        })
    }
}


struct ScriptBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptBackgroundView(script: Script(title: "Script 1", author: "Miumiu"))
    }
}
