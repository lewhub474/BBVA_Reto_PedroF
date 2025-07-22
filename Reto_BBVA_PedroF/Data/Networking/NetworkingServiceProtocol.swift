//
//  TransactionServiceProtrocol.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

protocol NetworkingServiceProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest,
                               decoder: JSONDecoder
    ) async throws -> T
}
