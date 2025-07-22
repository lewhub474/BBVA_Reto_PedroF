//
//  MockGetAllBookmarksUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//


import XCTest
@testable import Reto_BBVA_PedroF

final class MockGetAllBookmarksUseCase: UseCase {
    
    var result: [Int] = [1,2,3,4]
    
    func execute(_ input: Any?) -> [Int] {
        return result
    }
}
