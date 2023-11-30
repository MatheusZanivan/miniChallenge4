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
        }
    }
}

struct SceneViewRepresentable: UIViewRepresentable {
    typealias UIViewType = SCNView
    let sceneView = SCNView()
    @Binding private var strScene: String
    @Binding private var strCamera: String
    @Binding private var didChangeStrCamera: Bool
    
    private var responseOnClick: (_ nodeName: String) -> Void
    
    init(strScene: Binding<String>, strCamera: Binding<String>, didChangeStrCamera: Binding<Bool>, responseOnClick: @escaping (_ nodeName: String) -> Void) {
        self._strScene = strScene
        self._strCamera = strCamera
        self._didChangeStrCamera = didChangeStrCamera
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
        
        guard let scene = SCNScene(named: strScene) else {
            return
        }
        scnView.scene = scene
        if let cameraNode = scene.rootNode.childNode(withName: strCamera, recursively: true) {
            // Adjust the duration as needed
            
            if didChangeStrCamera {
                scnView.pointOfView = cameraNode
            } else {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1.0
                
                scnView.pointOfView = cameraNode
    //            strCamera = String()
                SCNTransaction.commit()
                didChangeStrCamera.toggle()
            }
                
            
        }
//        scnView.scene.background.contents = UIColor.clear
        
        scnView.allowsCameraControl = true
        scnView.isUserInteractionEnabled = true
//        scnView.showsStatistics = true
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sceneView, responseOnClick: responseOnClick)
    }
}

