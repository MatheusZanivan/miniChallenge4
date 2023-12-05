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
                        if !steps.isEmpty {
                            ForEach(steps, id: \.self) { step in
                                HStack{
                                    Text(step)
                                        .foregroundStyle(Color.GSFontBody)
                                        .fontWeight(.bold)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .padding([.leading], 16)
                                    Spacer()
                                }
                                .frame(height: 90)
                                Divider()
                            }                            
                        }
                    } else {
                        ProgressView()
                    }
                }
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(8)
            }
            .padding()
            .onReceive(graphDataLoader.$graph, perform: { _ in
                graphDidLoad = true
                bestWayViewModel.graph = Graph(graph: graphDataLoader.graph)
            })
            .onChange2(of: startingNode, action17: { _, _ in
                steps = bestWayViewModel.findBestWay(startingNode: startingNode.lowercased(), arrivalNode: arrivalNode.lowercased())
                if steps.isEmpty {
                    invalidData = true
                }
            }, actionLower: { _ in
                steps = bestWayViewModel.findBestWay(startingNode: startingNode.lowercased(), arrivalNode: arrivalNode.lowercased())
                if steps.isEmpty {
                    invalidData = true
                }
            })
            .onChange2(of: arrivalNode, action17: { _, _ in
                steps = bestWayViewModel.findBestWay(startingNode: startingNode.lowercased(), arrivalNode: arrivalNode.lowercased())
                if steps.isEmpty {
                    invalidData = true
                }
            }, actionLower: { _ in
                steps = bestWayViewModel.findBestWay(startingNode: startingNode.lowercased(), arrivalNode: arrivalNode.lowercased())
                if steps.isEmpty {
                    invalidData = true
                }
            })
            .frame(height: 600)
            .onAppear {
                steps = bestWayViewModel.findBestWay(startingNode: startingNode.lowercased(), arrivalNode: arrivalNode.lowercased())
                if steps.isEmpty {
                    invalidData = true
                }
            }
    }

        
}
