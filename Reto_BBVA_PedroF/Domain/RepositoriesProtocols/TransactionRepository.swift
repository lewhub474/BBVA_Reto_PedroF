//
//  TransactionRepository.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

protocol TransactionRepository {
    func fetchTransactions() async throws -> Record
}
