//
//  SelectScriptView.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import SwiftUI

struct SelectScriptView: View {
    @EnvironmentObject var scriptdb : ScriptDB
    
    @State private var searchText = ""
    let urlsring = "http://vcm-30653.vm.duke.edu:8080/game/start"
    
    var filteredScripts: [Script] {
        if searchText.isEmpty {
            return scriptdb.record
        } else {
            return scriptdb.record.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.author.localizedCaseInsensitiveContains(searchText) ||
                $0.background.localizedCaseInsensitiveContains(searchText)
            }
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
                            Text(script.author)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .onAppear{
                scriptdb.fetchAndUpdateData(urlString: urlsring)
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
