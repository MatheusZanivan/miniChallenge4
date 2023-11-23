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
    @State var indexSteps = Int()
    @State var invalidData = false
    
    var body: some View {
        ScrollView {
            VStack {
                if graphDidLoad {
                    Button {
                        indexSteps = 0
                        steps = bestWayViewModel.findBestWay(startingNode: startingNode.lowercased(), arrivalNode: arrivalNode.lowercased())
                        if steps.isEmpty {
                            invalidData = true
                        }
                    } label: {
                        Text("Calcular menor caminho")
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(.green)
                            .cornerRadius(16)
                    }
                    .alert(isPresented: $invalidData) {
                        Alert(title: Text("Alerta"), message: Text("Dados inseridos são inválidos."))
                    }
                    .padding(.bottom)
                    
                    if !steps.isEmpty {
                        StepsComponent(steps: $steps, indexStep: $indexSteps)
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.white)
        .onReceive(graphDataLoader.$graph, perform: { _ in
            graphDidLoad = true
            bestWayViewModel.graph = Graph(graph: graphDataLoader.graph)
        })
    }
    
    
}

#Preview {
    ContentView()
}
