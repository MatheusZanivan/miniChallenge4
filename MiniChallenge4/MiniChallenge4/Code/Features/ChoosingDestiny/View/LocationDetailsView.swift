//
//  LocationDetailsView.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 10/11/23.
//

import SwiftUI

struct LocationDetailsView: View {
    @State private var places: [WardModel] = []
    @EnvironmentObject private var vmSenac: SenacMapViewModel
    @State private var showSheetRoute = false
    private let place: String
    private let columns = [
        GridItem(.fixed(64)),
        GridItem(.fixed(64)),
        GridItem(.fixed(64))
    ]
    init(place: String) {
        self.place = place
    }
    var body: some View {
        ZStack {
            VStack{
                LazyVGrid(columns: columns, spacing: 10, content: {
                    GridRow {
                        ForEach(places, id:\.corredor) { place in
                            Button(action: {
                                
                            }, label: {
                                Text(place.corredor)
                                    .padding()
                                    .frame(width: 64, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.white)
                            })
                        }
                    }
                    .padding(.horizontal, 60)
                })
                Spacer()
                
                HStack{
                    RoundButton(action: {
                        showSheetRoute.toggle()
                    }, imageButton: Image(uiImage: UIImage(named: "Regular-S")!))
                    
                    Spacer()
                }.padding()
            }.padding(.vertical)
        }.background(Color.gray)
        .navigationTitle(self.place)
        .toolbarTitleDisplayMode(.inline)
        .onAppear(perform: {
            self.places = vmSenac.filterWard(from: place) ?? []
        })
    }
}
