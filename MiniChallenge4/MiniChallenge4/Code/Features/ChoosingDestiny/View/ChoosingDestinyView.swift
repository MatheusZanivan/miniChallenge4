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
    
    var body: some View {
        NavigationView{
            VStack{
                
                DropdownMenu(selectedOption: self.$placeSelect,
                             places: senacMapViewModel.senacMap,
                             placeholder: "Selecione uma área de Destino")
                
                Spacer()
                
                HStack(content: {
                    VStack{
                        Text("Selecione o Corredor")
                            .frame(minWidth: 150, idealWidth: 180, maxWidth: 200)
                            .padding([.bottom, .top], 18)
                            .foregroundColor(.black)
                            .background(.white)
                        ScrollView {
                            if let senacFiltered = senacMapViewModel.filterWard(from: placeSelect ?? "Local não selecionado") {
                                if !senacFiltered.isEmpty {
                                    ForEach(senacFiltered, id: \.corredor) { place in
                                        
                                        NavigationLink(place.corredor){
                                            RouteView(classRoomSenac: place.salas)
                                        }
                                        .padding([.bottom, .top], 8)
                                        .frame(minWidth: 150, idealWidth: 180, maxWidth: 200)
                                        .foregroundStyle(Color.black)
                                        
                                    }
                                } else {
                                    Text("Nenhuma informação encontrada nessa área")
                                        .padding([.bottom, .top], 8)
                                        .frame(minWidth: 150, idealWidth: 180, maxWidth: 200)
                                        .foregroundStyle(Color.black)
                                }
                                
                            } else {
                                Text("Nenhuma área selecionada até o momento")
                                    .padding([.bottom, .top], 8)
                                    .frame(minWidth: 150, idealWidth: 180, maxWidth: 200)
                                    .foregroundStyle(Color.black)
                            }
                        }.background(Color(uiColor: .systemGray3))
                            .padding(.top, -8)
                    }
                    .cornerRadius(16)
                    .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.75)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 0)
                    }
                })
    
                HStack {
                    RoundButton(action: {
                        showSheetRoute.toggle()
                    }, imageButton: Image(uiImage: UIImage(named: "Regular-S")!))
                    
                    Spacer()
                    RoundButton(action: {
                        print("imagem")
                    }, imageButton: Image(uiImage: UIImage(named: "Image")!))
                }.padding()
            }.background(Color.gray)
            
        }
        .sheet(isPresented: $showSheetRoute) {
            SheetAddRouteView()
                .presentationDetents([.height(200),.medium, .large])
                .presentationDragIndicator(.hidden)
            
        }
    }
}
