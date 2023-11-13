//
//  SheetAddRouteView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 07/11/23.
//

import SwiftUI

struct SheetAddRouteView: View {
    
    @State private var showSheetSelectDestiny = false
    
    var body: some View {
        VStack(content: {
            HStack(content: {
                Text("Mapa, sou o mapa")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Button("Fechar") {
                    
                }
            }).padding()
            RectangularButton(action: {showSheetSelectDestiny.toggle()}, title: "Onde você está")
                .sheet(isPresented: $showSheetSelectDestiny, content: {
                    withAnimation {
                        SheetSelectDestinyView(destiny: "")
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.hidden)
                    }
                })
            RectangularButton(action: {showSheetSelectDestiny.toggle()}, title: "Onde você quer ir")
                .sheet(isPresented: $showSheetSelectDestiny, content: {
                    
                })
            Spacer()
        })
    }
}
