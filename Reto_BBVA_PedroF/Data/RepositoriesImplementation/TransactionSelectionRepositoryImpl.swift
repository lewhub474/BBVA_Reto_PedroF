//
//  TransactionSelectionRepositoryImpl.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class TransactionSelectionRepositoryImpl: TransactionSelectionRepository {
    private let defaults = UserDefaults.standard
    private let key = "selectedTransactionIDs"

    func getSelectedTransactionIDs() -> [Int] {
        defaults.array(forKey: key) as? [Int] ?? []
    }

    func isSelected(transactionID: Int) -> Bool {
        getSelectedTransactionIDs().contains(transactionID)
    }

    func toggleSelection(for transactionID: Int) {
        var ids = getSelectedTransactionIDs()
        if ids.contains(transactionID) {
            ids.removeAll { $0 == transactionID }
        } else {
            ids.append(transactionID)
        }
        defaults.set(ids, forKey: key)
    }
}
