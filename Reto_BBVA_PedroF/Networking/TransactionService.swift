//
//  NetworkingJSON.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

//import Foundation
//
//final class TransactionService {
//    
//    static let shared = TransactionService()
//    
//    private init() { }
//    
//    func fetchTransactions(completion: @escaping (Result<Record, TransactionServiceError>) -> Void) {
//        guard let url = URL(string: "https://api.jsonbin.io/v3/b/687e9f36f7e7a370d1eb9ee0") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // Manejo de errores de red
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(.failure(.requestFailed(error)))
//                }
//                return
//            }
//
//            // Validar código de respuesta HTTP
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode),
//                  let data = data else {
//                DispatchQueue.main.async {
//                    completion(.failure(.invalidResponse))
//                }
//                return
//            }
//
//            // Decodificar
//            do {
//                let decoded = try JSONDecoder().decode(TransactionResponse.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(decoded.record))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(.decodingFailed))
//                }
//            }
//        }.resume()
//    }
//}

import Foundation

final class TransactionService: TransactionServiceProtocol {
    
    static let shared = TransactionService()
    
    private init() { }

    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: endpoint)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw TransactionServiceError.unknown
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw TransactionServiceError.serverError(code: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw TransactionServiceError.decodingError
            }
            
        } catch {
            throw TransactionServiceError.requestFailed(error)
        }
    }
}
