//
//  RouteView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 04/11/23.
//

import SwiftUI

struct RouteView: View {
    let classRoomSenac: [ClassroomModel]
    @State private var destino: String
    @State private var suaLocalizacao = String()
    
    init(classRoomSenac: [ClassroomModel]) {
        self.classRoomSenac = classRoomSenac
        self.destino = classRoomSenac[0].nome
    }
    
    var body: some View {
        VStack(content: {
            Text("A rota do destino pode aparecer aqui")
                .foregroundStyle(.white)
            Spacer()
            Form {
                Picker("Selecione seu destino", selection: $destino){
                    ForEach(classRoomSenac, id: \.nome){ classRoom in
                        Text(classRoom.nome)
                    }
                }
                TextField("Indique uma sala próxima", text: $suaLocalizacao)
            }
            .frame(minHeight: 150, idealHeight: 150, maxHeight: 150)
            .scrollContentBackground(.hidden)

            Button(action: {}, label: {
                Text("Calcular Rota")
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(.green)
                    .cornerRadius(16)
            })
        }).background(Color.gray)
        
    }
}
