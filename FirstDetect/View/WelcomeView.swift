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
            Image("welcomeImg")
                .resizable()
                .frame(width: 400.0, height: 400.0)
            
            Text("Welcome to\nBe the detective!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            
            Button(action: {
                self.showSelectView = true
                
            }, label: {
                Text("Get started")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 330.0, height: 60.0)
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
