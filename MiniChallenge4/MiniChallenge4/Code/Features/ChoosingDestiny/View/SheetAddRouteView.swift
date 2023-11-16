//
//  SheetAddRouteView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 07/11/23.
//

import SwiftUI

struct SheetAddRouteView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showSheetSelectDestiny = false
    @State private var showSheetSelectYourLocation = false
    @State private var yourLocation: String = String()
    
    var body: some View {
        VStack(content: {
            HStack(content: {
                Text("Mapa, sou o mapa")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Button("Fechar") {
                    dismiss()
                }
            }).padding()
            RectangularButton(action: {showSheetSelectYourLocation.toggle()}, title: self.yourLocation)
                .sheet(isPresented: $showSheetSelectYourLocation, content: {
                    withAnimation {
                        SheetSelectDestinyView(destiny: $yourLocation, title: "Onde você está")
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.hidden)
                    }
                })
            RectangularButton(action: {showSheetSelectDestiny.toggle()}, title: "Onde você quer ir")
                .sheet(isPresented: $showSheetSelectDestiny, content: {
                    SheetSelectDestinyView(destiny: $yourLocation, title: "Onde você quer ir")
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.hidden)
                })
            Spacer()
        })
    }
}
