//
//  Graph.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 01/11/23.
//

import Foundation

class Graph {
    
    var graph: [NodeJSONModel]
    var graphAlgorithm = [NodeModel]()
    var way = [String]()
    
    init(graph: [NodeJSONModel]) {
        self.graph = graph
        generateGraphAlgorithm()
    }
    
    func generateGraphAlgorithm() {
        graphAlgorithm = [NodeModel]()
        for node in graph {
            if !graphAlgorithm.contains(where: { $0.node.nome == node.no.nome}) {
                graphAlgorithm.append(NodeModel(node: node.no, value: -1, weight: 999999999, antecedent: nil, nodeRelationships: [NodeRelationshipModel(node: node.noConexao, weight: node.pesoAcao, action: node.acao)]))
            } else {
                if let nodeIndex = graphAlgorithm.firstIndex(where: { $0.node.nome == node.no.nome }) {
                    if !graphAlgorithm[nodeIndex].nodeRelationships.contains(where: {$0.node.nome == node.noConexao.nome}) {
                        graphAlgorithm[nodeIndex].nodeRelationships.append(NodeRelationshipModel(node: node.noConexao, weight: node.pesoAcao, action: node.acao))
                    } else {
                        print(node.no.nome)
                        print(node.noConexao.nome)
                    }
                }
            }
        }
        
        for node in graphAlgorithm {
            for relation in node.nodeRelationships {
                if let index = graphAlgorithm.firstIndex(where: {$0.node.nome == relation.node.nome}) {
                    if !graphAlgorithm[index].nodeRelationships.contains(where: {$0.node.nome == node.node.nome}) {
                        print("\(graphAlgorithm[index].node.nome) - \(node.node.nome)")
                        
                    }
                }
            }
        }

//        for no in graphAlgorithm {
//            print("\n")
//            print("\(no.node.nome) || \(no.nodeRelationships)")
//            print("\n")
//        }

        print("\n\n\n\n\n\n\n")
    }
    
    func dfsR(startingNode: String, arrivalNode: String, weight: Int = 0) {
        if let startingNodeIndex = graphAlgorithm.firstIndex(where: { $0.node.nome == startingNode}) {
            
            if graphAlgorithm[startingNodeIndex].node.nome == arrivalNode {
                generateWay(arrivalNode: arrivalNode)
                return
            }
            
            if graphAlgorithm[startingNodeIndex].weight == 999999999 {
                graphAlgorithm[startingNodeIndex].weight = weight
            }
            graphAlgorithm[startingNodeIndex].value = 0
            
            let startingNodeGraphAlgorithm = graphAlgorithm[startingNodeIndex]
            var adj = [String]()
            
            for i in 0...(startingNodeGraphAlgorithm.nodeRelationships.count - 1) {
                if let nextNodeIndex = graphAlgorithm.firstIndex(where: { $0.node.nome == startingNodeGraphAlgorithm.nodeRelationships[i].node.nome}) {
//                    if let indexAntecedent = graphAlgorithm.firstIndex(where: {$0.node.nome == graphAlgorithm[nextNodeIndex].antecedent ?? String()}) {
//                        if let graphAlgorithm[indexAntecedent].antecedent ==
//                    }
                    if ((weight + 1) < graphAlgorithm[nextNodeIndex].weight && startingNodeGraphAlgorithm.antecedent != graphAlgorithm[nextNodeIndex].node.nome){
                        graphAlgorithm[nextNodeIndex].weight = weight + startingNodeGraphAlgorithm.nodeRelationships[i].weight
                        graphAlgorithm[nextNodeIndex].antecedent = startingNodeGraphAlgorithm.node.nome
                        graphAlgorithm[nextNodeIndex].value = 0
                        adj.append(graphAlgorithm[nextNodeIndex].node.nome)
                        print("\(graphAlgorithm[startingNodeIndex].node.nome) - \(graphAlgorithm[nextNodeIndex].node.nome)")
                        
                        
//                        if noPartidaGrafoAlgoritmo.relacaoNos[i].acao == "direita" {
//                            print("\(noPartida) virou a direita para \(grafoAlgoritmo[indexProximoNo].nome)")
//                        } else if noPartidaGrafoAlgoritmo.relacaoNos[i].acao == "esquerda" {
//                            print("\(noPartida) virou a esquerda para \(grafoAlgoritmo[indexProximoNo].nome)")
//                        } else {
//                            print("\(noPartida) seguiu reto para \(grafoAlgoritmo[indexProximoNo].nome)")
//                        }
                    }
                }
            }
            for a in adj {
                if let nextNodeIndex = graphAlgorithm.firstIndex(where: { $0.node.nome == a}) {
                    dfsR(startingNode: graphAlgorithm[nextNodeIndex].node.nome, arrivalNode: arrivalNode, weight: weight + 1)
//                    print(a)
                }
            }
//            if let indexNoParaDeletar = grafoAlgoritmo.firstIndex(where: { $0.nome == noPartida}) {
//                grafoAlgoritmo.remove(at: indexNoParaDeletar)
//            }
            
        }
    }
    
    func generateWay(arrivalNode: String) {
        var nodeList = [String]()
        var currentNode = arrivalNode
        while true {
            if let startingNodeIndex = graphAlgorithm.firstIndex(where: { $0.node.nome == currentNode}) {
                print("\(graphAlgorithm[startingNodeIndex].node.nome) - \(graphAlgorithm[startingNodeIndex].antecedent ?? "")")
                nodeList.append(graphAlgorithm[startingNodeIndex].node.nome)
                currentNode = graphAlgorithm[startingNodeIndex].antecedent ?? ""
            } else {
                break;
            }
        }
        nodeList.reverse()
        generateSteps(nodeList: nodeList)
    }
    
    func generateSteps(nodeList: [String]) {
        if (nodeList.count < way.count && !way.isEmpty) || way.isEmpty {
            way.removeAll()
            for i in 0...(nodeList.count - 1) {
                if let startingNodeIndex = graphAlgorithm.firstIndex(where: { $0.node.nome == nodeList[i]}) {
                    let nodeRelationships = graphAlgorithm[startingNodeIndex].nodeRelationships
                    
                    if !((i + 1) > (nodeList.count - 1)) {
                        if let nodeRelationshipIndex = nodeRelationships.firstIndex(where: {$0.node.nome == nodeList[i + 1]}) {
                            way.append("De \(nodeList[i]) \(nodeRelationships[nodeRelationshipIndex].action) para \(nodeList[i + 1])")
                        }
                    }
                }
            }
        }
        mergeStraightActions()
    }
    
    func mergeStraightActions() {
        var startingNodeActionStraight = String()
        var newWay = [String]()
        
        for i in 0...(way.count - 1) {
            let wayDetails = way[i].split(separator: " ")
            if wayDetails[2].lowercased() == "reto" {
                if startingNodeActionStraight == String() {
                    startingNodeActionStraight = String(wayDetails[1])
                }
                if (i + 1) > (way.count - 1) {
                    newWay.append("De \(startingNodeActionStraight) reto até \(String(wayDetails[4]))")
                    startingNodeActionStraight = String()
                } else if String(way[i + 1].split(separator: " ")[2]) != "reto" {
                    newWay.append("De \(startingNodeActionStraight) reto até \(String(wayDetails[4]))")
                    startingNodeActionStraight = String()
                }
            } else {
                newWay.append(way[i])
            }
        }
        way = newWay
    }
}

