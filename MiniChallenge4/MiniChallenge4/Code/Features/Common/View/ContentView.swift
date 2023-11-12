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
    var body: some View {
//        SceneView(scene: SCNScene(named: "art.scnassets/snorlax.scn"), options: [.allowsCameraControl, .autoenablesDefaultLighting])
//            .gesture(
//                TapGesture(count: 1).onEnded { tap in
//                    let location = tap.location(in: )
//                    let hitResults = UIApplication.shared.windows.first?.rootViewController?.view.hitTest(location, with: nil)
//
//                    if let hitNode = hitResults?.first?.node {
//                        // Handle the tap on the 3D object
//                        print("Tapped on \(hitNode.name ?? "Unknown node")")
//                    }
//                }
//            )
        SceneViewRepresentable()

    }
}

#Preview {
    ContentView()
}
