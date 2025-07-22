//
//  TransactionServiceProtrocol.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

protocol TransactionServiceProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T
}
