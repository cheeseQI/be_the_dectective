//
//  ContentView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var chatdb = ChatDB.shared
    @State var text = ""
    @StateObject private var scriptdb = ScriptDB.shared
    var body: some View {
        WelcomeView()
            .environmentObject(scriptdb)
            .environmentObject(chatdb)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
