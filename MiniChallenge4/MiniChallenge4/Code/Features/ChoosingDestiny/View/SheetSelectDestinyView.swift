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
    @State var emptyClassrooms: String?
//    private var filtered: [SenacPlaceModel]{
//        guard !search.isEmpty else {return senacMapViewModel.senacMap}
//        return senacMapViewModel.senacMap.filter { place in
//            place.nome.lowercased().contains(search.lowercased())
//        }
//    }

    init(destiny: Binding<String>, title: String) {
        self._destiny = destiny
        self.title = title
    }
    
    var body: some View {
        NavigationView(content: {
            ZStack(content: {
                Color.GSBackground.ignoresSafeArea()
                VStack(content: {
                    if let emptyClassrooms {
                        Text("\(emptyClassrooms)")
                    } else {
                        ScrollView {
                            ForEach(senacMapViewModel.senacClassrooms) { place in
                                Button(place.nome) {
                                    self.destiny = place.nome
                                    dismiss()
                                }
                            }
                        }
                    }
                    
                    Spacer()
                })
                .onChange2(of: search, action17: { _, newValue in
                    emptyClassrooms = senacMapViewModel.filterClassrooms(text: newValue)
                }, actionLower: { newValue in
                    emptyClassrooms = senacMapViewModel.filterClassrooms(text: newValue)
                })
                .searchable(text: $search)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {dismiss()}, label: {
                            Text("Cancelar")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        })
                    }
                })
            })
        })
    }
}

extension UISearchBar {
    func setTextFieldColor(_ color: UIColor) {
            for subView in self.subviews {
                for subSubView in subView.subviews {
                    let view = subSubView as? UITextInputTraits
                    if view != nil {
                        let textField = view as? UITextField
                        textField?.backgroundColor = color
                        break
                    }
                }
            }
        }
}
