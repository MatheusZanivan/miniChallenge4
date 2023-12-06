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
    
    @State var nodeName = "scenes.scnassets/campus/sceneCampus.scn"
    @State var cameraName = String()
    @State var nodeWay = [String]()
    var body: some View {
        ZStack {
//            SceneViewRepresentable(strScene: nodeName, strCamera: $cameraName, oi: .constant("oi"), responseOnClick: { nodeName in
//                print(nodeName)
//                
////                switch Int.random(in: 0...1) {
////                case 0:
////                    self.cameraName = "camera"
////                case 1:
////                    self.cameraName = "camera2"
////                default:
////                    self.cameraName = "camera2"
////                }
//                
////                self.nodeName = "scenes.scnassets/\(nodeName)/scene\(nodeName.capitalized).scn"
//                print(self.nodeName)
//                
//            })
            VStack {
                Text(nodeName)
                Spacer()
            }
        }
        .onChange2(of: nodeName, action17: { _, newValue in
            nodeWay.append(newValue)
        }, actionLower: { newValue in
            nodeWay.append(newValue)
        })
        .onAppear {
            nodeWay.append(nodeName)
        }
//=======
//        VStack {
//			CameraViewControlerRepresentable()
//				.ignoresSafeArea()
//        }
//        .padding()
//>>>>>>> origin/artwork_recognizer
    }
}

