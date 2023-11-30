//
//  LocationDetailsView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 10/11/23.
//

import SwiftUI

struct LocationDetailsView: View {
    @EnvironmentObject private var vmSenac: SenacMapViewModel
    @Environment(\.dismiss) var dismiss
    private var place: String
    @State private var wards: [WardModel] = []
    @State private var showSheetRoute = false
    @State private var currentPlace = String()
    @State private var current3DPlace = String()
    @State private var currentStair = 0
    @State private var classroomSelected = String()
    @State var showRoute = false
    
    @State var placeColorChoosed = String()
    
    init(place: String) {
        self.place = place
    }
    
    var body: some View {
        ZStack {
            SceneViewRepresentable(strScene: current3DPlace, strCamera: String()) { nodeName in
                if let classroom = vmSenac.findClassroomInfo(classroom: nodeName) {
                    classroomSelected = nodeName
                }
            }
            .ignoresSafeArea()
            VStack{
                HStack {
                    Spacer()
                    VStack {
                        ForEach(wards, id:\.corredor) { place in
                            RectangularButton(
                                action: {
                                    placeColorChoosed = place.corredor
//                                    color = color == placeColor ? .white : placeColor
                                },
                                title: Binding.constant(place.corredor),
                                color: $placeColorChoosed,
                                edgesActive: true,
                                borderColor: Color("GSColor-\(place.corredor)"),
                                maxWidth: 32,
                                aligmentCenter: true)
                            
                        }
                    }
                }.padding()
                
                Spacer()
                if classroomSelected != String() {
                    HStack {
                        ClassroomCard(action: {
                            showRoute.toggle()
                        }, classroomNumber: $classroomSelected, color: Color("GSColor-\(classroomSelected)"))
                        .sheet(isPresented: $showRoute) {
                            SheetAddRouteView(yourDestiny: classroomSelected == String() ? nil : classroomSelected)
                        }
                    }
                } else {
                    HStack(alignment: .bottom){
                        RoundButton(action: {
                            showSheetRoute.toggle()
                        }, imageButton: Image(uiImage: UIImage(named: "GSMap")!), activeBackground: true)
                        .sheet(isPresented: $showSheetRoute) {
                            SheetAddRouteView(yourDestiny: nil)
                                .ignoresSafeArea()
                        }
                        Spacer()
                        if vmSenac.verifyIfThereIsUpstairs(wards: wards) {
                            VStack {
                                RoundButton(action: {
                                    currentStair = 1
                                }, 
                                            imageButton: Image("GSArrowUp"),
                                            frameHeight: 40,
                                            frameWidth: 40,
                                            padding: 4)
                                .opacity(currentStair == 1 ? 0.5 : 1)
                                RoundButton(action: {
                                    currentStair = 0
                                }, 
                                            imageButton: Image("GSArrowDown"),
                                            frameHeight: 40,
                                            frameWidth: 40,
                                            padding: 0)
                                .opacity(currentStair == 0 ? 0.5 : 1)
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.vertical, 32)
        }
        .background(Color.gray)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(self.place)
                    .fontWeight(.bold)
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
            current3DPlace = "scenes.scnassets/\(currentPlace.lowercased())/scene\(currentPlace.capitalized).scn"
        } else {
            current3DPlace = "scenes.scnassets/\(currentPlace.lowercased())PriAndar/scene\(currentPlace.capitalized)PriAndar.scn"
        }
    }
}
