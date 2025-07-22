//
//  GetSelectedTransactionsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

final class GetSelectedTransactionsUseCase {
     let repository: TransactionSelectionRepository

    init(repository: TransactionSelectionRepository) {
        self.repository = repository
    }

    func execute() -> [Int] {
           let ids = repository.getSelectedTransactionIDs()
           print("📥 GetSelectedTransactionsUseCase - IDs recuperados: \(ids)")
           return ids
       }
}

final class ToggleTransactionSelectionUseCase {
    private let repository: TransactionSelectionRepository

    init(repository: TransactionSelectionRepository) {
        self.repository = repository
    }

    func execute(transactionID: Int) {
            print("🔁 ToggleTransactionSelectionUseCase - Toggling ID: \(transactionID)")
            repository.toggleSelection(for: transactionID)
        }
}
