//
//  MockGetShouldHideAmountsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//


import XCTest
@testable import Reto_BBVA_PedroF

final class MockGetShouldHideAmountsUseCase: UseCase {
    var result: Bool = true
    func execute(_ input: Any?) -> Bool {
        return result
    }
}


