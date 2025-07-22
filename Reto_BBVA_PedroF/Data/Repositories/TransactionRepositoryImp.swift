//
//  TransactionRepositoryImp.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class TransactionRepositoryImpl: TransactionRepository {
    
    func fetchTransactions() async throws -> Record {
        let request = try TransactionRequestBuilder.makeRequest(
            endpoint: .custom(path: "v3/b/687e9f36f7e7a370d1eb9ee0"),
            method: "GET",
            environment: .development
        )
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw TransactionServiceError.requestFailed(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw TransactionServiceError.serverError(code: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let decoded = try JSONDecoder().decode(TransactionResponse.self, from: data)
            return decoded.record
        } catch {
            throw TransactionServiceError.decodingError
        }
    }
}



