//
//  NpcInfoView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/26/23.
//

import SwiftUI

struct NpcInfoView: View {
    let info: Chat
    var body: some View {
        Text(info.background)
    }
}

struct NpcInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NpcInfoView(info: Chat(username: "Miumiu", lastMessageText: "", messages: []))
    }
}
