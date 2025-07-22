//
//  GetTransactionUseCase}.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class GetTransactionsUseCase: AsyncUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository = TransactionRepositoryImpl()) {
        self.repository = repository
    }

    func execute(_ input: Any?) async throws -> Record {
        return try await repository.fetchTransactions()
    }
}
