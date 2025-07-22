//
//  Transaction.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

enum TransactionType: String, Decodable {
    case income = "ingreso"
    case expense = "egreso"
}

struct Transaction: Decodable, Equatable {
    let id: Int
    let name: String
    let amount: Double
    let date: String
    let type: TransactionType
}

// TransactionSection.swift
import Foundation

struct TransactionSection {
    let date: String
    let transactions: [Transaction]
}

extension Array where Element == Transaction {
    func groupedByDate() -> [TransactionSection] {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale(identifier: "es_ES")
        displayFormatter.dateFormat = "d 'de' MMMM"
        
        // 1. Agrupar usando Date
        let grouped = Dictionary(grouping: self) { transaction -> Date in
            inputFormatter.date(from: transaction.date) ?? Date.distantPast
        }
        
        // 2. Ordenar por Date descendente (más reciente primero)
        let sorted = grouped.sorted { $0.key > $1.key }

        // 3. Mapear a [TransactionSection] con String de fecha para mostrar
        return sorted.map { (date, transactions) in
            let dateString = displayFormatter.string(from: date)
            return TransactionSection(date: dateString, transactions: transactions)
        }
    }
}

