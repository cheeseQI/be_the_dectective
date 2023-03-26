//
//  ClueView.swift
//  FirstDetect
//
//  Created by oliver xu on 3/25/23.
//

import SwiftUI

struct ClueView: View {
    var scene : Image
    var searchSceneUrl = ""
    var body: some View {
        VStack {
            Text("Search the scene")
            scene
                .resizable()
        }
    }
}

struct ClueView_Previews: PreviewProvider {
    static var previews: some View {
        ClueView(scene: Image("welcomeImg"))
    }
}
