//
//  TransactionError.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

enum TransactionServiceError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError(code: Int)
    case requestFailed(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
         
            return "URL inválida"
            
        case .decodingError:
            return "Error al decodificar los datos"
            
        case .serverError(let code):
            return "Error del servidor (\(code))"
            
        case .requestFailed(let error):
            return "Error en la petición: \(error.localizedDescription)"
            
        case .unknown:
            return "Error desconocido"
        }
    }
}



