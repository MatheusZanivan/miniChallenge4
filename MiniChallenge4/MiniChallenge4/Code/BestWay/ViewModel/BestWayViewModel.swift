//
//  BestWayViewModel.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/11/23.
//

import Foundation

class BestWayViewModel: ObservableObject {
    
    @Published var graph: Graph? = nil
    
    init() {}
    
    func achaMelhorCaminho(noOrigem: String, noDestino: String) -> [String] {
        graph?.way = [String]()
        graph?.dfsR(startingNode: noOrigem, arrivalNode: noDestino)
        print("melhor caminho = \n\(graph?.way ?? [String]())")
        graph?.generateGraphAlgorithm()
        return graph?.way ?? [String]()
    }
}
