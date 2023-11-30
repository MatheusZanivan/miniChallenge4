//
//  ClassroomCard.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 22/11/23.
//

import Foundation
import SwiftUI

struct ClassroomCard: View {
    @EnvironmentObject private var vmSenac: SenacMapViewModel
    
    @Binding var classroomNumber: String
    private let action: () -> Void
    private let color: Color
    
    init(action: @escaping () -> Void, classroomNumber: Binding<String>, color: Color) {
        self.action = action
        self._classroomNumber = classroomNumber
        self.color = color
    }
    
    var body: some View {
        VStack {
            Text(classroomNumber)
                .frame(minWidth: 72, minHeight: 28)
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.5))
                .cornerRadius(25)
                .padding()
                .foregroundStyle(.black)
            if let classrooom = vmSenac.findClassroomInfo(classroom: classroomNumber) {
                Text(classrooom.andar)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing, .bottom])
                    .foregroundStyle(.white)
                
                if let descricao = classrooom.descricao {
                    Text(descricao)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing, .bottom])
                        .foregroundStyle(.white)
                        
                }
            }
            Spacer()
            Button {
                action()
            } label: {
                Text("Traçar rota")
                    .fontWeight(.bold)
                    .foregroundStyle(.gsFontBody)
                    .frame(minWidth: 260)
                    .padding()
            }
            .background(.white)

        }
        .frame(minWidth: 260, maxHeight: 192)
        .background(.gray)
        .shadow(radius: 10)
        .cornerRadius(5)
        
    }
}
