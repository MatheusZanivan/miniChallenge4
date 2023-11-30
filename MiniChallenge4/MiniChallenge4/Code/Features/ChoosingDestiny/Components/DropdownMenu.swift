//
//  DropdownMenu.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 01/11/23.
//

import SwiftUI

struct DropdownMenu: View {
    
    @State private var isOptionsPresented = false
    @Binding var selectedOption: String?
    let places: [SenacPlaceModel]
    let placeholder: String
    
    var body: some View {
        Button(action: {withAnimation {
            self.isOptionsPresented.toggle()
        }}) {
            HStack{
                Text(selectedOption == nil ? placeholder : selectedOption!)
                    .foregroundStyle(selectedOption == nil ? .gray : .black)
                Spacer()
                Image(systemName: self.isOptionsPresented ? "chevron.up" : "chevron.down")
                    .foregroundStyle(.gray)
            }
            .padding()
//            .padding(.bottom, self.isOptionsPresented ? 260 : 0)
            .background(Color.white)
            .cornerRadius(5)
        }
        .padding([.leading, .trailing], 24)
        .overlay(alignment: .top) {
            VStack{
                if self.isOptionsPresented{
                    Spacer()
                    DropdownMenuList(options: self.places, onSelectionAction: { option in
                        withAnimation {
                            self.isOptionsPresented = false
                            self.selectedOption = option.nome
                        }
                    })
                    .frame(height: 260)
                }
            }.foregroundStyle(.black)
                .padding(.horizontal, 24)
        }
    }
}
