//
//  TransactionSelectionRepository.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

protocol TransactionSelectionRepository {
    func getSelectedTransactionIDs() -> [Int]
    func isSelected(transactionID: Int) -> Bool
    func toggleSelection(for transactionID: Int)
}
