//
//  WelcomeView.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showSelectView = false
    @EnvironmentObject var scriptdb : ScriptDB
    let urlsring = "http://vcm-30653.vm.duke.edu:8080/game/start"
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50)
            
            Button(action: {
                self.showSelectView = true
                scriptdb.fetchAndUpdateData(urlString: urlsring)
            }, label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
        }
        .environmentObject(scriptdb)
        .fullScreenCover(isPresented: $showSelectView, content: {
            SelectScriptView()
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
