//
//  NpcInfoView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/26/23.
//

import SwiftUI

struct NpcInfoView: View {
    let info: Chat
    @State var randColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    var body: some View {
        VStack {
            Rectangle()
                .fill(randColor)
                .ignoresSafeArea(edges: .top)
                .frame(height: 190)
                .padding(.bottom, -10)
            CircleImage(img: Image(systemName: "person.crop.circle"))
                .offset(y: -100)
                .padding(.bottom, -100)
            Text(info.username)
                .font(.title)
                .fontWeight(.bold)
            Text(info.background)
            Spacer()
        }
    }
}


struct CircleImage: View {
    
    var img: Image
    
    var body: some View {
        img
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}


struct NpcInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NpcInfoView(info: Chat(username: "Miumiu", lastMessageText: "", messages: []))
    }
}
