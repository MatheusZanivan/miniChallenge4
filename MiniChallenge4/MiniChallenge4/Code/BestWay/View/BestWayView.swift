//
//  BestWayView.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/11/23.
//

import SwiftUI

struct BestWayView: View {
    @StateObject var graphDataLoader = GraphDataLoader()
    @StateObject var bestWayViewModel = BestWayViewModel()
    @State var graphDidLoad = false
    @Binding var startingNode: String
    @Binding var arrivalNode: String
    @State var steps = [String]()
    @State var invalidData = false
    
    var body: some View {
        ScrollView {
            VStack {
                if graphDidLoad {
//                    TextField("Sala origem", text: $startingNode)
//                        .textInputAutocapitalization(.never)
//                        .padding()
//                        .background()
//                        .cornerRadius(10)
//                        .padding()
//                    TextField("Sala destino", text: $arrivalNode)
//                        .textInputAutocapitalization(.never)
//                        .padding()
//                        .background()
//                        .cornerRadius(10)
//                        .padding()
//                    
                    Button {
                        steps = bestWayViewModel.findBestWay(startingNode: startingNode, arrivalNode: arrivalNode)
                        if steps.isEmpty {
                            invalidData = true
                        }
                    } label: {
                        Text("Calcular menor caminho")
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $invalidData) {
                        Alert(title: Text("Alerta"), message: Text("Dados inseridos são inválidos."))
                    }
                    
                    if !steps.isEmpty {
                        StepsComponent(steps: $steps)
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.gray)
        .onReceive(graphDataLoader.$graph, perform: { _ in
            graphDidLoad = true
            bestWayViewModel.graph = Graph(graph: graphDataLoader.graph)
        })
    }
    
    
}

#Preview {
    ContentView()
}
