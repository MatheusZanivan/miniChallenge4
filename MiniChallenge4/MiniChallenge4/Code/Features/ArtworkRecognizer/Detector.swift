//
//  Detector.swift
//  MiniChallenge4
//
//  Created by Matheus Zanivan on 17/11/23.
//

import UIKit
import AVFoundation
import Vision


//para ter acesso dos frames da camera nós temos o AVCaptureDataOutput como um segundo output na nossa capture session
extension CameraViewControler {
	func setUpDetector(){
		//pegamos o caminho do nosso modelo e depois carregamos
		let modelUrl = Bundle.main.url(forResource: "ModeloTesteComOutros", withExtension: "mlmodel")
		do {
			let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelUrl!))
			let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
			self.requests = [recognitions]
		} catch let error {
			print(error)
		}
		
	}
	
	
	
}
