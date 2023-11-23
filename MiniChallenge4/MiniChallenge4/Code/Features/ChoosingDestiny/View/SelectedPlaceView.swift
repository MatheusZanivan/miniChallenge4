//
//  LocationDetailsView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 10/11/23.
//

import SwiftUI

struct SelectedPlaceView: View {
    @EnvironmentObject private var vmSenac: SenacMapViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var wards: [WardModel] = []
    @State private var classroomSelected = String()
    
    private var place: String
    @State private var currentPlace = String()
    @State private var currentStair = 0
    
    @State private var strScene = String()
    @State private var strCamera = String()
    @State private var didChangeStrCamera = false
    
    @State private var showRouteWithSelectedDestiny = false
    @State private var showSheetRoute = false
    
    init(place: String) {
        self.place = place
    }
    
    var body: some View {
        ZStack {
            SceneViewRepresentable(strScene: $strScene, strCamera: $strCamera, didChangeStrCamera: $didChangeStrCamera) { nodeName in
                if let classroom = vmSenac.findClassroomInfo(classroom: nodeName) {
                    classroomSelected = nodeName
                }
            }
            .ignoresSafeArea()
            HStack {
                if vmSenac.verifyIfThereIsUpstairs(wards: wards) {
                    VStack {
                        Button {
                            currentStair = 1
                        } label: {
                            Image(systemName: "chevron.up")
                                .foregroundStyle(.gray)
                                .padding()
                                .background(.white)
                                .cornerRadius(5)
                                .opacity(currentStair == 1 ? 0.5 : 1)
                        }

                        Button {
                            currentStair = 0
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.gray)
                                .padding()
                                .background(.white)
                                .cornerRadius(5)
                                .opacity(currentStair == 0 ? 0.5 : 1)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            
            VStack{
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        ForEach(wards, id:\.corredor) { ward in
                            Button(action: {
                                didChangeStrCamera.toggle()
                                strCamera = ward.corredor
                            }, label: {
                                Text(ward.corredor)
                                    .padding()
                                    .foregroundStyle(.gray)
                                    .frame(width: 64, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            })
                        }
                    }
                }
                
                Spacer()
                if classroomSelected != String() {
                    ClassroomCard(action: {
                        showRouteWithSelectedDestiny.toggle()
                    }, classroomNumber: $classroomSelected)
                    .sheet(isPresented: $showRouteWithSelectedDestiny) {
                        SheetAddRouteView(yourDestiny: classroomSelected == String() ? nil : classroomSelected)
                    }
                } else {
                    HStack{
                        RoundButton(action: {
                            showSheetRoute.toggle()
                        }, imageButton: Image(uiImage: UIImage(named: "Regular-S")!))
                        .sheet(isPresented: $showSheetRoute) {
                            SheetAddRouteView(yourDestiny: nil)
                                .ignoresSafeArea()
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding()
        }
        .background(Color.gray)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(self.place)
                    .foregroundStyle(Color("guiarse_blue"))
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color("guiarse_blue"))
                }

            }
        })
        .onChange2(of: currentStair, action17: { _, newValue in
            current3DPlaceUpdate(newValue: newValue)
        }, actionLower: { newValue in
            current3DPlaceUpdate(newValue: newValue)
        })
        .onAppear(perform: {
            currentPlace = place.forSorting.split(separator: " ").joined()
            current3DPlaceUpdate(newValue: currentStair)
            self.wards = vmSenac.filterWard(from: place) ?? []
        })
    }
    
    func current3DPlaceUpdate(newValue: Int) {
        if newValue == 0 {
            strScene = "scenes.scnassets/\(currentPlace.lowercased())/scene\(currentPlace.capitalized).scn"
        } else {
            strScene = "scenes.scnassets/\(currentPlace.lowercased())PriAndar/scene\(currentPlace.capitalized)PriAndar.scn"
        }
    }
}