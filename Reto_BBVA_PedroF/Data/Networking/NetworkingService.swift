//
//  NetworkingJSON.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class NetworkingService: NetworkingServiceProtocol {
    private let session: URLSession
    private let successStatusCodes: ClosedRange<Int> = 200...299

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: URLRequest,
                               decoder: JSONDecoder = .init()) async throws -> T {
        do {
            let (data, response) = try await session.data(for: endpoint)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingServiceError.unknown
            }

            guard (successStatusCodes).contains(httpResponse.statusCode) else {
                throw NetworkingServiceError.serverError(code: httpResponse.statusCode)
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkingServiceError.decodingError
            }

        } catch {
            throw NetworkingServiceError.requestFailed(error)
        }
    }
}
