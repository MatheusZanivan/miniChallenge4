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
class CameraViewControler : UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
	private var permissionGranted = false //flag da permissão
	private var captureSession = AVCaptureSession()
	private var sessionQueue = DispatchQueue(label: "sessionQueue")
	private var previewLayer = AVCaptureVideoPreviewLayer()
	var screenRect : CGRect! = nil// para dimensao da view
	
	//detection
	private var videoOutput = AVCaptureVideoDataOutput()
	var requests = [VNRequest]()
	
	
	override func viewDidLoad() {
		checkPermission()
		
		sessionQueue.async { [unowned self] in
			guard permissionGranted else { return }
			self.setupCaptureSession()
			self.captureSession.startRunning()
			
			self.setUpDetector()
		}
	}
	
	func checkPermission(){
		switch AVCaptureDevice.authorizationStatus(for: .video){
			//ja foi permitido o uso da camera antes
		case .authorized:
			permissionGranted = true
			//ainda não foi permetido o uso da camera
		case .notDetermined:
			requestPermission()
			
		default:
			permissionGranted = false
		}
	}
	
	func requestPermission(){
		sessionQueue.suspend()
		AVCaptureDevice.requestAccess(for: .video, completionHandler: {[unowned self] granted in
			self.permissionGranted = granted
			self.sessionQueue.resume()
		})
	}
	
	func setupCaptureSession() {
		// Camera input
		guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera,for: .video, position: .back) else { return }
		guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
		
		guard captureSession.canAddInput(videoDeviceInput) else { return }
		captureSession.addInput(videoDeviceInput)
		
		// Preview layer
		screenRect = UIScreen.main.bounds
		
		previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
		previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
		previewLayer.connection?.videoOrientation = .portrait
		
		//aqui nós setamos a classe viewControler como o buffer delegate e conectamos o output com o nosso capture session
		videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
		captureSession.addOutput(videoOutput)
		
		videoOutput.connection(with: .video)?.videoOrientation = .portrait
		
		// Updates to UI must be on main queue
		DispatchQueue.main.async { [weak self] in
			self!.view.layer.addSublayer(self!.previewLayer)
		}
	}
}

struct CameraViewControlerRepresentable : UIViewControllerRepresentable{
	func makeUIViewController(context: Context) -> some UIViewController {
		return CameraViewControler()
	}
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
