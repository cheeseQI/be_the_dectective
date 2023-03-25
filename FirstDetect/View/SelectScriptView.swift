//
//  SelectScriptView.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import SwiftUI

struct SelectScriptView: View {
    @State private var scripts = [
        Script(title: "Script 1", info: "This is info1"),
        Script(title: "Script 2", info: "This is info2"),
        Script(title: "Script 3", info: "This is info3"),
        Script(title: "Script 4", info: "This is info4"),
        Script(title: "Script 5", info: "This is info5")
    ]
    @State private var searchText = ""
    
    var filteredScripts: [Script] {
        if searchText.isEmpty {
            return scripts
        } else {
            return scripts.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.info.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredScripts, id: \.id) { script in
                NavigationLink(destination: ScriptBackgroundView(script: script)) {
                    HStack {
                        Image(systemName: "doc")
                            .padding(.trailing, 8)
                        VStack(alignment: .leading) {
                            Text(script.title)
                                .font(.headline)
                            Text(script.info)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Select a Script")
            .searchable(text: $searchText)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}




struct SelectScriptView_Previews: PreviewProvider {
    static var previews: some View {
        SelectScriptView()
    }
}
