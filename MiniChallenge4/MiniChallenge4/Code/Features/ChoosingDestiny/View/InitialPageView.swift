//
//  HomeView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 01/11/23.
//

import SwiftUI

struct InitialPageView: View {
    @EnvironmentObject var senacMapViewModel: SenacMapViewModel
    @State private var placeSelect: String?
    @State private var showSheetRoute = false
    @State private var showSheetCamera = false
    @State private var showSelectedPlace = false
    
    @State var nodeName = "scenes.scnassets/campus/sceneCampus.scn"
    @State var cameraName = String()
    @State var nodeWay = [String]()
    
    var body: some View {
        NavigationStack {
            ZStack{
                SceneViewRepresentable(strScene: $nodeName, strCamera: $cameraName, didChangeStrCamera: .constant(false), responseOnClick: { nodeName in
                    if senacMapViewModel.verifyIfPlaceExists(place: nodeName) {
                        self.nodeName = senacMapViewModel.getPlaceFrom3DPathPlace(place: nodeName)
                        showSelectedPlace.toggle()
                    }
                })
                .ignoresSafeArea()
                .navigationDestination(isPresented: $showSelectedPlace) {
                    SelectedPlaceView(place: self.nodeName)
                }
                
                VStack {
                    DropdownMenu(selectedOption: self.$placeSelect,
                                 places: senacMapViewModel.senacMap,
                                 placeholder: "Selecione uma área")
                    
                    Spacer()
        
                    HStack {
                        RoundButton(action: {
                            showSheetRoute.toggle()
                        }, imageButton: Image(uiImage: UIImage(named: "GSMap")!), activeBackground: true)
                        .sheet(isPresented: $showSheetRoute) {
                            SheetAddRouteView(destiny: nil)
                                .presentationDetents([.height(200),.medium, .large])
                                .presentationDragIndicator(.hidden)
                        }
                        
                        Spacer()
                        
                        RoundButton(action: {
                            showSheetCamera.toggle()
                        }, imageButton: Image(uiImage: UIImage(named: "GSCamera")!), activeBackground: true)
                        .sheet(isPresented: $showSheetCamera) {
                            CameraViewControlerRepresentable()
                                .ignoresSafeArea()
                        }
                    }.padding()
                }.padding(.vertical, 32)
                
            }.background(Color.gray)
            
        }
        .onReceive(senacMapViewModel.$senacMap) { _ in
            senacMapViewModel.setClassrooms()
        }
        
            
        
    }
}
