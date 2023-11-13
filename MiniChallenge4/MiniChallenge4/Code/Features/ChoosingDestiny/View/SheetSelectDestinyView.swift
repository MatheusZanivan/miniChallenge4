//
//  SheetSelectDestinyView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 07/11/23.
//

import SwiftUI

struct SheetSelectDestinyView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var destiny: String
    
//    init(destiny: String) {
//        self.destiny = destiny
//    }
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                TextField("", text: $destiny)
                    .frame(minWidth: 200, idealWidth: 300, maxWidth: 300, alignment:.leading)
                    .padding([.vertical], 8)
                    .padding(.horizontal)
                    .background(Color(red: 0.75, green: 0.75, blue: 0.75))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 0)), style: FillStyle())
                    .foregroundColor(Color(red: 0.47, green: 0.47, blue: 0.47))
                Spacer()
            })
            .navigationTitle("Onde você está")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ok") {
                        dismiss()
                    }
                }
            })
        })
        
    }
}
