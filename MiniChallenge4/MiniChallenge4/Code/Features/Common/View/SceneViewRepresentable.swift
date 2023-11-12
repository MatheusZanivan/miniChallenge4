//
//  SceneViewRepresentable.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 10/11/23.
//

import Foundation
import SceneKit
import SwiftUI

class SceneViewRepresentableCoordinator: NSObject {
    @objc func didClickObject(_ sender: UITapGestureRecognizer) {
        print("OI")
//        let sceneView = sender.view as! SCNView
//        
//        let location = sender.location(in: sceneView)
//        let results = sceneView.hitTest(location, options: [SCNHitTestOption.searchMode : 1])
//        print("OI")
//
//        for result in results.filter( { $0.node.name != nil }) {
//            
//            if result.node.name == "Your node name" {
//                // excuse some actions
//            }
//        }
    }
}

struct SceneViewRepresentable: UIViewRepresentable {
    typealias UIViewType = SCNView
    let scene = SCNScene()
    
    func makeUIView(context: Context) -> SCNView {
        scene.rootNode.addChildNode(createSnorlax())
        
        let coordinator = SceneViewRepresentableCoordinator()
        
        let sceneView = SCNView()
        let tap = UITapGestureRecognizer(target: coordinator, action: #selector(coordinator.didClickObject))
        sceneView.addGestureRecognizer(tap)
        sceneView.scene = scene
        return sceneView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.gray
        scnView.isUserInteractionEnabled = true
        scnView.showsStatistics = true
    }
}

extension SceneViewRepresentable {
    func createSnorlax() -> SCNNode {
        let snorlax = SCNScene(named: "art.scnassets/snorlax.scn")
        let node: SCNNode = snorlax?.rootNode.childNode(withName: "Mesh_1__Body01_", recursively: true) ?? SCNNode()
        return node
    }
}


