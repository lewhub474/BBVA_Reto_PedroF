//
//  Transaction.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

struct Transaction: Decodable {
    let id: Int
    let name: String
    let amount: Double
    let date: String
    let type: String // "ingreso" o "egreso"
}

// TransactionSection.swift
import Foundation

struct TransactionSection {
    let date: String
    let transactions: [Transaction]
}

extension Array where Element == Transaction {
    func groupedByDate() -> [TransactionSection] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale(identifier: "es_ES")
        displayFormatter.dateFormat = "d 'de' MMMM"
        
        let grouped = Dictionary(grouping: self) { transaction -> String in
            guard let date = formatter.date(from: transaction.date) else { return "Sin fecha" }
            return displayFormatter.string(from: date)
        }
        
        let sorted = grouped.sorted { lhs, rhs in
            guard let lhsDate = formatter.date(from: lhs.key),
                  let rhsDate = formatter.date(from: rhs.key) else { return false }
            return lhsDate > rhsDate
        }
        
        return sorted.map { TransactionSection(date: $0.key, transactions: $0.value) }
    }
}
