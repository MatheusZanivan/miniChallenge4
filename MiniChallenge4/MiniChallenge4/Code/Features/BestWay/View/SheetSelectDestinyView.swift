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
    @State var filteredClassrooms: [ClassroomModel] = []
    
    init(destiny: Binding<String>, title: String) {
        self._destiny = destiny
        self.title = title
    }
    
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                if filteredClassrooms.isEmpty {
                    ScrollView {
                        ForEach(senacMapViewModel.senacClassrooms) { place in
                            Button(place.nome) {
                                self.destiny = place.nome
                                dismiss()
                            }
                        }
                    }
                } else {
                    List(filteredClassrooms, id: \.id) { classroom in
                        Text(classroom.nome)
                            // Exibir outras informações da sala conforme necessário
                            .onTapGesture {
                                self.destiny = classroom.nome
                                dismiss()
                            }
                    }
                }
                
                Spacer()
            })
            .searchable(text: $search, prompt: "Search") // Adicionando um prompt para a caixa de pesquisa
            .onChange(of: search) { newValue in
                // Atualizar a lista de salas filtradas quando o texto da pesquisa mudar
                filteredClassrooms = senacMapViewModel.filterClassrooms(text: newValue)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ok") {
                        dismiss()
                    }
                }
            })
            // ZStack(content: {
            //     Color.GSBackground.ignoresSafeArea()
            //     VStack(content: {
            //         if let emptyClassrooms {
            //             Text("\(emptyClassrooms)")
            //         } else {
            //             ScrollView {
            //                 ForEach(senacMapViewModel.senacClassrooms) { place in
            //                     Button(place.nome) {
            //                         self.destiny = place.nome
            //                         dismiss()
            //                     }
            //                 }
            //             }
            //         }
                    
            //         Spacer()
            //     })
            //     .onChange2(of: search, action17: { _, newValue in
            //         emptyClassrooms = senacMapViewModel.filterClassrooms(text: newValue)
            //     }, actionLower: { newValue in
            //         emptyClassrooms = senacMapViewModel.filterClassrooms(text: newValue)
            //     })
            //     .searchable(text: $search)
            //     .navigationTitle(title)
            //     .navigationBarTitleDisplayMode(.inline)
            //     .toolbar(content: {
            //         ToolbarItem(placement: .cancellationAction) {
            //             Button(action: {dismiss()}, label: {
            //                 Text("Cancelar")
            //                     .fontWeight(.bold)
            //                     .foregroundStyle(.red)
            //             })
            //         }
            //     })
            // })
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
