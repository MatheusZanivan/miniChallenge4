//
//  GraphTests.swift
//  MiniChallenge4Tests
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 03/11/23.
//

import XCTest
import Combine
@testable import MiniChallenge4

final class GraphTests: XCTestCase {
    var graphDataLoader: GraphDataLoader?
    var cancellable: Set<AnyCancellable>?
    var graph: Graph?

    override func setUpWithError() throws {
        graphDataLoader = GraphDataLoader()
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
    }

    func testGraph() throws {
        graphDataLoader?
            .$graph
            .sink { [self] graph in
                XCTAssertFalse(graph.isEmpty)
                creationOfGraphAlgorithm()
                wayToTest()
                
            }
            .store(in: &(cancellable)!)
    }
    
    func creationOfGraphAlgorithm() {
        graph = Graph(graph: graphDataLoader?.graph ?? [NodeJSONModel]())
        XCTAssertNotNil(graph?.graphAlgorithm)
    }
    
    func wayToTest() {
        graph?.dfsR(startingNode: "i339", arrivalNode: "j475")
        XCTAssertFalse(graph?.way.isEmpty ?? true)
        graph?.way = [String]()
        graph?.dfsR(startingNode: "i339k", arrivalNode: "j475")
        XCTAssertTrue(graph?.way.isEmpty ?? false)
    }

}
