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
    
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50)
            
            Button(action: {
                self.showSelectView = true
                
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
