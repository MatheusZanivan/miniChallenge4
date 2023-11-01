//
//  DecodingSenacJsonMap.swift
//  MiniChallenge4Tests
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 31/10/23.
//

import XCTest
import Combine
@testable import MiniChallenge4


final class DecodingSenacJsonMap: XCTestCase {
    func testSenacMapDataLoader() throws {
        let senacMapViewModel = SenacMapViewModel()
        var cancellables = Set<AnyCancellable>()
        senacMapViewModel
            .$senacMap
            .sink(receiveValue: { newSenacMap in
                XCTAssertNil(newSenacMap)
            })
            .store(in: &cancellables)
    }
}
