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
    @State private var yourDestiny = String()
    
    private var destiny: String?
    
    init(destiny: String?) {
        self.destiny = destiny
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "GSFontTItle")!]
    }
    
    var body: some View {
        NavigationView(content: {
            VStack( content: {
                RectangularButton(action: {
                    showSheetSelectYourLocation.toggle()
                }, title: yourLocation == String() ? .constant("Onde você está") : $yourLocation, color: .constant(String()))
                    .sheet(isPresented: $showSheetSelectYourLocation, content: {
                        withAnimation {
                            SheetSelectDestinyView(destiny: $yourLocation, title: "Onde você está")
                                .presentationDetents([.medium, .large])
                                .presentationDragIndicator(.hidden)
                        }
                    })
                RectangularButton(action: {
                    showSheetSelectDestiny.toggle()
                }, title: yourDestiny == String() ? .constant("Onde você quer ir") : $yourDestiny, color: .constant(String()))
                    .sheet(isPresented: $showSheetSelectDestiny, content: {
                        SheetSelectDestinyView(destiny: $yourDestiny, title: "Onde você quer ir")
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.hidden)
                    })
                
                if yourDestiny != String() && yourLocation != String() {
                    BestWayView(startingNode: $yourLocation, arrivalNode: $yourDestiny)
                        .padding()
                }
                Spacer()
                    .frame(maxWidth: .infinity)

            })
            .background(Color.GSBackground)
            .navigationTitle("Descrições")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let destiny {
                    self.yourDestiny = destiny
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action:  {dismiss()}, label: {
                        Image("GSCloseButton")
                    })
                }
            })
            
        })
    }
}
