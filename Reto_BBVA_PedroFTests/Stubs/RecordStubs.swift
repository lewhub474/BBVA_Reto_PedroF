//
//  RecordStubs.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

@testable import Reto_BBVA_PedroF

enum RecordStubs {
    static var emptyRecord = Record(balance: 0, transactions: [])

    static var balance: Double {
        return 1000
    }

    static var transactions: [Transaction] {
        return [
            .init(id: 1, name: "Income 1", amount: 100, date: "", type: .income),
            .init(id: 2, name: "Income 2", amount: 100, date: "", type: .income),
            .init(id: 3, name: "Income 3", amount: 100, date: "", type: .income),
            .init(id: 4, name: "Expense 1", amount: 100, date: "", type: .expense),
            .init(id: 5, name: "Expense 2", amount: 100, date: "", type: .expense)
        ]
    }
    static func createRecord(
        balance: Double = RecordStubs.balance,
        transactions: [Transaction] = RecordStubs.transactions
    ) -> Record {
        .init(balance: balance, transactions: transactions)
    }
}
