//
//  ContentView.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 30/10/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @StateObject var senacMapViewModel = SenacMapViewModel()
    
    @State var nodeName = "art.scnassets/sceneAcademico1.scn"
    @State var nodeWay = [String]()
    var body: some View {
        ZStack {
            SceneViewRepresentable(strScene: nodeName, responseOnClick: { nodeName in
                if nodeName == "Cube_001" {
                    print(nodeName)
                    self.nodeName = "art.scnassets/sceneOla.scn"
                }
            })
            VStack {
                Text(nodeName)
                Spacer()
            }
        }
        .onChange(of: nodeName, { _, newValue in
            nodeWay.append(newValue)
        })
        .onAppear {
            nodeWay.append(nodeName)
        }
    }
}

#Preview {
    ContentView()
}
