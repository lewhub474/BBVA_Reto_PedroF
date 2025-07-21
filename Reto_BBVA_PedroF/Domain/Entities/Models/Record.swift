//
//  Record.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

struct Record: Decodable {
    let balance: Double
    let transactions: [Transaction]
}
