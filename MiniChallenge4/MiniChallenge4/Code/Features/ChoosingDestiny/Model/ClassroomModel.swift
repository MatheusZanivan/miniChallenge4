//
//  ClassroomModel.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/10/23.
//

import Foundation

struct ClassroomModel: Codable, Identifiable {
    let id = UUID()
    let nome: String
    let andar: String
    let descricao: String?
}


