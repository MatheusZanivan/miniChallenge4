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
    
    init(action: @escaping () -> Void, classroomNumber: Binding<String>) {
        self.action = action
        self._classroomNumber = classroomNumber
    }
    
    var body: some View {
        VStack {
            Text(classroomNumber)
                .padding()
                .foregroundStyle(.gray)
            if let classrooom = vmSenac.findClassroomInfo(classroom: classroomNumber) {
                Text(classrooom.andar)
                    .padding([.leading, .trailing, .bottom])
                    .foregroundStyle(.gray)
                
                if let descricao = classrooom.descricao {
                    Text(descricao)
                        .padding([.leading, .trailing, .bottom])
                        .background(.gray)
                        .foregroundStyle(.white)
                        
                }
            }
            Button {
                action()
            } label: {
                Text("Ir")
            }

        }
        .background(.white)
        .shadow(radius: 10)
        .cornerRadius(5)
        
    }
}
