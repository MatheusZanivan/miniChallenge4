//
//  NodeJSONModel.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/11/23.
//

import Foundation

struct NodeJSONModel: Codable {
    let pesoAcao: Int
    let acao: String
    let no: ClassroomNodeModel
    let noConexao: ClassroomNodeModel
}
