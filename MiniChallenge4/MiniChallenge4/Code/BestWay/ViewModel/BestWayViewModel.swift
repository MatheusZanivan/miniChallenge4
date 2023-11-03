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
    
    func findBestWay(startingNode: String, arrivalNode: String) -> [String] {
        graph?.way = [String]()
        graph?.dfsR(startingNode: startingNode, arrivalNode: arrivalNode)
        print("melhor caminho = \n\(graph?.way ?? [String]())")
        graph?.generateGraphAlgorithm()
        return graph?.way ?? [String]()
    }
}
