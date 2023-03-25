//
//  ScriptBackgroundView.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import SwiftUI

struct ScriptBackgroundView: View {
    let script: Script
    
    var body: some View {
        VStack {
            ScrollView {
                Text(script.background)
                    .padding()
            }
            Spacer()
            Button(action: {
                // Navigate back to MainView
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
        .navigationTitle(script.title)
    }
}

struct ScriptBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptBackgroundView(script: Script(title: "Script 1", info: "This is info1"))
    }
}
