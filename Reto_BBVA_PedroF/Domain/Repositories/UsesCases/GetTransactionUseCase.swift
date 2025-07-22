//
//  GetTransactionUseCase}.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class GetTransactionsUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository) {
        self.repository = repository
    }

    func execute() async throws -> Record {
        return try await repository.fetchTransactions()
    }
}
