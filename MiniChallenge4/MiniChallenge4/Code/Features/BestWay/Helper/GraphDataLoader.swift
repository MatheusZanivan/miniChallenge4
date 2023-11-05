//
//  GraphDataLoader.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/11/23.
//

import Foundation

class GraphDataLoader: ObservableObject {
    @Published var graph = [NodeJSONModel]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let file = Bundle.main.path(forResource: "graph", ofType: "json") {
            do {
                guard let contentOfFile = try String(contentsOfFile: file).data(using: .utf8) else {
                    print("Could not get contents of file.")
                    return
                }
                graph = try JSONDecoder().decode([NodeJSONModel].self, from: contentOfFile)
            } catch {
                print("Could not decode data.")
            }
        } else {
            print("Could not find file.")
        }
    }
}

