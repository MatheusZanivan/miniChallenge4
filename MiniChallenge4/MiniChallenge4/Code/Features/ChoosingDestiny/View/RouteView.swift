//
//  RouteView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 04/11/23.
//

import SwiftUI

struct RouteView: View {
    let classRoomSenac: [ClassroomModel]
    @State private var destiny: String
    @State private var location = String()
    
    init(classRoomSenac: [ClassroomModel]) {
        self.classRoomSenac = classRoomSenac
        self.destiny = classRoomSenac[0].nome
    }
    
    var body: some View {
        VStack(content: {
//            Text("A rota do destino pode aparecer aqui")
//                .foregroundStyle(.white)
            BestWayView(startingNode: .constant("i339"), arrivalNode: $destiny)
            Spacer()
            Text("Por padrão você está no laboratório i347 (Laboratório Apple)")
            Form {
                Picker("Selecione seu destino", selection: $destiny){
                    ForEach(classRoomSenac, id: \.nome){ classRoom in
                        Text(classRoom.nome)
                    }
                }
//                TextField("Indique uma sala próxima", text: $location)
            }
            .frame(minHeight: 150, idealHeight: 150, maxHeight: 150)
            .scrollContentBackground(.hidden)

//            Button(action: {}, label: {
//                Text("Calcular Rota")
//                    .padding()
//                    .foregroundStyle(Color.white)
//                    .background(.green)
//                    .cornerRadius(16)
//            })
        }).background(Color.gray)
        
    }
}
