//
//  SenacMapViewModel.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/10/23.
//

import Foundation

final class SenacMapViewModel: ObservableObject {
    @Published var senacMap = [SenacPlaceModel]()
    @Published var senacClassrooms = [ClassroomModel]()
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
    
    func verifyIfPlaceExists(place: String) -> Bool {
        return senacMap.contains(where: {
            $0.nome.lowercased() == place.lowercased() ||
            (($0.alas?.contains(where: {
                $0.corredor.lowercased() == place.lowercased() ||
                $0.salas.contains(where: { $0.nome.lowercased() == place.lowercased() })
            })) != nil)
        })
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
    
    func verifyIfThereIsUpstairs(wards: [WardModel]?) -> Bool {
        if let wards {
            for ward in wards {
                for classrooms in ward.salas {
                    if classrooms.andar.lowercased() == "primeiro andar" {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    func findClassroomInfo(classroom: String) -> ClassroomModel? {
        for senacPlace in senacMap {
            if let wards = senacPlace.alas {
                for ward in wards {
                    for classRoom in ward.salas {
                        if classRoom.nome == classroom {
                            return classRoom
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func setClassrooms() {
        senacClassrooms = [ClassroomModel]()
        for place in senacMap {
            if let wards = place.alas {
                for ward in wards {
                    for classroom in ward.salas {
                        senacClassrooms.append(classroom)
                    }
                }
            }
            
        }
    }
    
    func filterClassrooms(text: String) -> String? {
        setClassrooms()
        print(senacClassrooms)
        senacClassrooms = senacClassrooms.filter({$0.nome.lowercased() == text.lowercased()})
        
        if senacClassrooms.isEmpty {
            return "Sem salas até o momento."
        }
        return nil
    }
}
