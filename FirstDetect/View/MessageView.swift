//
//  MessageView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct MessageView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isSentByCurrentUser {
                Spacer()
            }
            Text(message.text)
                .padding(10)
                .background(message.isSentByCurrentUser ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            if !message.isSentByCurrentUser {
                Spacer()
            }
        }.padding(.horizontal)
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(text: "Hello", isSentByCurrentUser: true))
    }
}
