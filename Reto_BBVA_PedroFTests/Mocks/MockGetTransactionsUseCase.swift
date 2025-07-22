//
//  MockGetTransactionsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

import XCTest
@testable import Reto_BBVA_PedroF

final class MockGetTransactionsUseCase: AsyncUseCase {
    var result: Record = RecordStubs.emptyRecord
    var error: Error?

    func execute(_ input: Any?) async throws -> Record {
        if let error {
            throw error
        }
        return result
    }
}
