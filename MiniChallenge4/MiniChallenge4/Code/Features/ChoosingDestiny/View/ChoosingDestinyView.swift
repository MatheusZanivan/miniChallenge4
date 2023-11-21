//
//  HomeView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 01/11/23.
//

import SwiftUI

struct ChoosingDestinyView: View {
    @EnvironmentObject var senacMapViewModel: SenacMapViewModel
    @State private var placeSelect: String?
    @State private var showSheetRoute = false
    @State private var showSheetCamera = false
    
    @State var nodeName = "scenes.scnassets/campus/sceneCampus.scn"
    @State var cameraName = String()
    @State var nodeWay = [String]()
    
    var body: some View {
        NavigationView{
            ZStack{
                
                
               
                SceneViewRepresentable(strScene: nodeName, strCamera: cameraName, responseOnClick: { nodeName in
                    print(nodeName)
                    
    //                switch Int.random(in: 0...1) {
    //                case 0:
    //                    self.cameraName = "camera"
    //                case 1:
    //                    self.cameraName = "camera2"
    //                default:
    //                    self.cameraName = "camera2"
    //                }
                    
    //                self.nodeName = "scenes.scnassets/\(nodeName)/scene\(nodeName.capitalized).scn"
                    print(self.nodeName)
                    
                })
                
                VStack {
                    DropdownMenu(selectedOption: self.$placeSelect,
                                 places: senacMapViewModel.senacMap,
                                 placeholder: "Selecione uma área de Destino")
                    
                    Spacer()
        
                    HStack {
                        RoundButton(action: {
                            showSheetRoute.toggle()
                        }, imageButton: Image(uiImage: UIImage(named: "Regular-S")!))
                        .sheet(isPresented: $showSheetRoute) {
                            SheetAddRouteView()
                                .presentationDetents([.height(200),.medium, .large])
                                .presentationDragIndicator(.hidden)
                        }
                        
                        Spacer()
                        RoundButton(action: {
                            showSheetCamera.toggle()
                        }, imageButton: Image(uiImage: UIImage(named: "Image")!))
                        .sheet(isPresented: $showSheetCamera) {
                            CameraViewControlerRepresentable()
                                .ignoresSafeArea()
                        }
                    }.padding()
                }
                
            }.background(Color.gray)
            
        }
        
            
        
    }
}
