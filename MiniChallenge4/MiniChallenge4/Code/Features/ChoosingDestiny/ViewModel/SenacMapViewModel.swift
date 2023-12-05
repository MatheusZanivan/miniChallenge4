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
    private var senacClassroomsFixed = [ClassroomModel]()
    
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
    
    func filterWard(from placeSelected: String, stair: String?)->[WardModel]?{
        if senacMap.isEmpty {return nil}
        for senacPlace in senacMap {
            if senacPlace.nome == placeSelected {
                if let stair {
                    return getWardsInStair(wards: senacPlace.alas, stair: stair)
                } else {
                    return senacPlace.alas
                }
            }
        }
        return nil
    }
    
    func getWardsInStair(wards: [WardModel]?, stair: String) -> [WardModel]? {
        var newWards = [WardModel]()
        if let wards {
            for ward in wards {
                for sala in ward.salas {
                    if sala.andar.forSorting.lowercased() == stair {
                        newWards.append(ward)
                        break;
                    }
                }
            }
            return newWards
        }
        
        return nil
    }
    
    func verifyIfPlaceExists(place: String) -> Bool {
        for senacPlace in senacMap {
            if senacPlace.nome.forSorting.split(separator: " ").joined().lowercased() == place.lowercased() {
                return true
            }
            if let wards = senacPlace.alas {
                for ward in wards {
                    if ward.corredor.forSorting.split(separator: " ").joined().lowercased() == place.lowercased() {
                        return true
                    }
                    for classroom in ward.salas {
                        if classroom.nome.forSorting.split(separator: " ").joined().lowercased() == place.lowercased() {
                            return true
                        }
                    }
                }
            }
        }
        
        return false
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
    
    func getPlaceFrom3DPathPlace(place: String) -> String {
        for senacPlace in senacMap {
            if senacPlace.nome.forSorting.split(separator: " ").joined().lowercased() == place.lowercased() {
                return senacPlace.nome
            }
        }
        return String()
    }
    
    func setClassrooms() {
        senacClassroomsFixed = [ClassroomModel]()
        for place in senacMap {
            if let wards = place.alas {
                for ward in wards {
                    for classroom in ward.salas {
                        senacClassroomsFixed.append(classroom)
                    }
                }
            } else if let classes = place.salas {
                for classe in classes {
                    senacClassrooms.append(classe)
                }
            }
            
        }
    }
    
    func filterClassrooms(text: String) -> [ClassroomModel] {
        setClassrooms()
        
        if text.isEmpty {
            return senacClassrooms // Retorna todas as salas se o texto estiver vazio
        }
        
        let filteredClassrooms = senacClassrooms.filter { classroom in
            // Filtra as salas com base na correspondência parcial do nome da sala com o texto inserido
            return classroom.nome.lowercased().contains(text.lowercased())
        }
        
        return filteredClassrooms
    }
}
