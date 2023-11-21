//
//  SceneViewRepresentable.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 10/11/23.
//

import Foundation
import SceneKit
import SwiftUI

class Coordinator: NSObject {
    private let view: SCNView
    
    private var responseOnClick: (_ nodeName: String) -> Void
    
    init(_ view: SCNView, responseOnClick: @escaping (_ nodeName: String) -> Void) {
        self.view = view
        self.responseOnClick = responseOnClick
        super.init()
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // check what nodes are tapped
        let p = gestureRecognize.location(in: view)
        let hitResults = view.hitTest(p, options: [:])
        
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            
            // retrieved the first clicked object
            let result = hitResults[0]
     
            // get material for selected geometry element
            
            let material = result.node.geometry!.materials[(result.geometryIndex)]
            print("\(result.node.name ?? "N/A") - \(result.node.name ?? "N/A")")
            responseOnClick(result.node.name ?? "N/A")
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
              
                SCNTransaction.commit()
            }
            material.emission.contents = UIColor.green
            SCNTransaction.commit()
        }
    }
}

struct SceneViewRepresentable: UIViewRepresentable {
    typealias UIViewType = SCNView
    let sceneView = SCNView()
    let strScene: String
    let strCamera: String
    
    private var responseOnClick: (_ nodeName: String) -> Void
    
    init(strScene: String, strCamera: String, responseOnClick: @escaping (_ nodeName: String) -> Void) {
        self.strScene = strScene
        self.strCamera = strCamera
        self.responseOnClick = responseOnClick
    }
    
    func makeUIView(context: Context) -> SCNView {
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        sceneView.scene = SCNScene(named: strScene)
        sceneView.isUserInteractionEnabled = true
        return sceneView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        withAnimation {
            guard let scene = SCNScene(named: strScene) else {
                return
            }
            scnView.scene = scene
        }
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.gray
        scnView.isUserInteractionEnabled = true
        scnView.showsStatistics = true
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sceneView, responseOnClick: responseOnClick)
    }
}

