//
//  SenacPlaceModel.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/10/23.
//

import Foundation

struct SenacPlaceModel: Codable {
    let nome: String
    let alas: [WardModel]?
}
