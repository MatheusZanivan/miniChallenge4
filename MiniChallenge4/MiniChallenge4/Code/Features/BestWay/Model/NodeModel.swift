//
//  Node.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/11/23.
//

import Foundation

struct NodeModel {
    let node: ClassroomNodeModel
    var value: Int
    var weight: Int
    var antecedent: String?
    var nodeRelationships: [NodeRelationshipModel]
}
