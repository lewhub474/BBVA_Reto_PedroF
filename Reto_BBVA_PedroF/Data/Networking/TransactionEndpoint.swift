//
//  TransactionsEndpoint.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

enum TransactionEndpoint {
    case getTransactions
    case custom(path: String)

    func url(baseURL: URL) -> URL {
        switch self {
        case .getTransactions:
            return baseURL
        case .custom:
            return baseURL
        }
    }
}
