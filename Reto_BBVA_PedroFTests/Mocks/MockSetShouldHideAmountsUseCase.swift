//
//  MockSetShouldHideAmountsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//


import XCTest
@testable import Reto_BBVA_PedroF

final class MockSetShouldHideAmountsUseCase: UseCase {
    var spyCounter = 0

    func execute(_ hidden: Bool) -> Any? {
        spyCounter += 1
    }
}
