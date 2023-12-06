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

//carregar uma sheet com a info da obra[
//                            switch senacMapViewModel.getSheetInfo(){
//                            case "telettubies":
//
//                            case "aviao":
//
//                            case "exhaust":
//
//                            case "cubo_vaastu":
//
//                            case "a_borboleta":
//
//                            case "a_estudante":
//
//                            case "chama_vermelha":
//
//                            case "jda_amarelo":
//
//                            case "jda_azul":
//
//                            case "leitor":
//
//                            case "mergulho_na_diversidade":
//
//                            case "tabela_periodica":
//
//                            case "heliquioidal_ferrugem":
//
//                            case "heliquioidal_dourado":
//
//                            case "mae_e_filha":
//
//                            case "galera_do_senac":
//
//                            case "escultura_madeira":
//
//                            default:
//                                break
//
//                            }


//temos que fazer com que o nosso AvFoundation tenha acesso à câmera, e precisamos ter acesso a cada frame dessa câmera
//o nosso controler tem duas funcoes aqui, checar se a gente tem permissão para usar a câmera e depois seta uma capturesession

//protocol ViewControllerDelegate: NSObject {
//    func getExhibitionName(exhibition: String)
//}

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
	
	
    var getExhibitionName: (_ exhibition: String) -> Void
    
    init(getExhibitionName: @escaping (_ exhibition: String) -> Void) {
        self.getExhibitionName = getExhibitionName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var sheetInfo : String?

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
		
		guard let model = try? VNCoreMLModel(for: artwork_recognizer_completo().model) else { return }
		let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
			
			
			guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
			
			guard let firstObservation = results.first else { return }
			
//			print(firstObservation.identifier, firstObservation.confidence)
			
            DispatchQueue.main.async { [self] in
//				self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
//                var obra = identificaObra(obra: firstObservation.identifier , acuracia: firstObservation.confidence)
                var confidence = firstObservation.confidence * 100
                if confidence > 99.00{
                    sheetInfo = firstObservation.identifier
                    if let sheetInfo {
                        if sheetInfo != "exhaust" {
                            getExhibitionName(sheetInfo)
                        }
                    }
                }
                
			}
			
		}
		
		try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
	}
    
    func identificaObra(obra : String, acuracia : Float) -> String {
        return "Obra não encontrada"
    }

}


struct CameraViewControlerRepresentable : UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var exhibitionName: String
	func makeUIViewController(context: Context) -> UIViewController {
        let VC = ViewController(getExhibitionName: { exhibtionName in
            self.exhibitionName = exhibtionName
            self.dismiss()
        })
        return VC
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
