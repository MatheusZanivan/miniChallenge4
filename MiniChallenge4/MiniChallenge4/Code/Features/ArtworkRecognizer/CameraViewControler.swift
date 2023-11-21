//
//  ViewControler.swift
//  MiniChallenge4
//
//  Created by Matheus Zanivan on 16/11/23.
//

import UIKit
import AVFoundation
import SwiftUI
import Vision


//temos que fazer com que o nosso AvFoundation tenha acesso à câmera, e precisamos ter acesso a cada frame dessa câmera
//o nosso controler tem duas funcoes aqui, checar se a gente tem permissão para usar a câmera e depois seta uma capturesession

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
	
	let identifierLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = .white
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let captureSession = AVCaptureSession()
		captureSession.sessionPreset = .photo
		
		guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
		guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
		captureSession.addInput(input)
		
		captureSession.startRunning()
		
		let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		view.layer.addSublayer(previewLayer)
		previewLayer.frame = view.frame
		
		let dataOutput = AVCaptureVideoDataOutput()
		dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
		captureSession.addOutput(dataOutput)
		
		setupIdentifierConfidenceLabel()
	}
	
	fileprivate func setupIdentifierConfidenceLabel() {
		view.addSubview(identifierLabel)
		identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
		identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		
		guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
		
		guard let model = try? VNCoreMLModel(for: ModeloTesteComOutros().model) else { return }
		let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
			
			
			guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
			
			guard let firstObservation = results.first else { return }
			
//			print(firstObservation.identifier, firstObservation.confidence)
			
			DispatchQueue.main.async {
				self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
			}
			
		}
		
		try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
	}

}


struct CameraViewControlerRepresentable : UIViewControllerRepresentable {
	func makeUIViewController(context: Context) -> UIViewController {
		return ViewController()
		}

		func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		}
}
