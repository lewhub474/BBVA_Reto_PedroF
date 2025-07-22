//
//  TransactionRequestBuilder.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

struct TransactionRequestBuilder {
    static func makeRequest(
        endpoint: TransactionEndpoint,
        method: String = "GET",
        body: Data? = nil,
        headers: [String: String] = [:],
        environment: Environment = .development
    ) throws -> URLRequest {
        guard let baseURL = environment.baseURL else {
            throw NetworkingServiceError.invalidURL
        }

        let url = endpoint.url(baseURL: baseURL)
        print("🌐 URL construida: \(url.absoluteString)") // 👉 Aquí el print para depurar

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body

        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        return request
    }
}
