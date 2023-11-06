//
//  SenacMapViewModel.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/10/23.
//

import Foundation

class SenacMapViewModel: ObservableObject {
    @Published var senacMap = [SenacPlaceModel]()
    
    init() {
        loadSenacMap()
    }
    
    func loadSenacMap() {
        if let senacMapFile = Bundle.main.path(forResource: "senac_map", ofType: "json") {
            do {
                guard let contentsOfSenacMapFile = try? String(contentsOfFile: senacMapFile).data(using: .utf8) else {
                    print("Could not convert senac map data to string.")
                    return
                }
                senacMap = try JSONDecoder().decode([SenacPlaceModel].self, from: contentsOfSenacMapFile)
                
            } catch {
                print("Could not decode data in senac map file.")
            }
        } else {
            print("Could not find senac map file.")
        }
    }
    
    func filterWard(from placeSelected: String)->[WardModel]?{
        if senacMap.isEmpty {return nil}
        for senacPlace in senacMap {
            if senacPlace.nome == placeSelected {
                return senacPlace.alas
            }
        }
        return nil
    }
    
    func filterLab(from placeSelected: String)->[WardModel]?{
        if senacMap.isEmpty {return nil}
        for senacPlace in senacMap {
            if senacPlace.nome == placeSelected {
                
                return senacPlace.alas
            }
        }
        return nil
    }
}
