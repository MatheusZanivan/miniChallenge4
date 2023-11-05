//
//  HomeView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 01/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var placeSelect: String?
    @StateObject var senacMapViewModel = SenacMapViewModel()
    
    var body: some View {
        NavigationStack{
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
                            .background(.white)
                        ScrollView {
                            ForEach(senacMapViewModel.filterWard(from: placeSelect ?? "Local não selecionado") ?? [], id: \.corredor) { place in
                                
                                NavigationLink(place.corredor){
                                    RouteView(classRoomSenac: place.salas)
                                }
                                .padding([.bottom, .top], 8)
                                .frame(minWidth: 150, idealWidth: 180, maxWidth: 200)
                                .foregroundStyle(Color.black)
                                
                            }
                        }.background(Color(uiColor: .systemGray3))
                            .padding(.top, -8)
                    }
                    .cornerRadius(16)
                    .frame(minWidth: 150, idealWidth: 180, maxWidth: 200, minHeight: 150, idealHeight: 150, maxHeight: 150)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 0)
                    }
                })
                
                
            }.background(Color.gray)
        }
        
        
    }
}
