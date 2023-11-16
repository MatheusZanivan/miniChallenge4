//
//  SheetSelectDestinyView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 07/11/23.
//

import SwiftUI

struct SheetSelectDestinyView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var senacMapViewModel: SenacMapViewModel
    @Binding var destiny: String
    private let title: String
    @State var search = String()
    private var filtered: [SenacPlaceModel]{
        guard !search.isEmpty else {return senacMapViewModel.senacMap}
        return senacMapViewModel.senacMap.filter { place in
            place.nome.lowercased().contains(search.lowercased())
        }
    }

    init(destiny: Binding<String>, title: String) {
        self._destiny = destiny
        self.title = title
    }
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                ScrollView {
                    ForEach(filtered, id: \.nome) { place in
                        Button(place.nome) {
                            self.destiny = place.nome
                            dismiss()
                        }
                    }
                }
                Spacer()
            })
            .searchable(text: $search)
            .navigationTitle(title)
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


