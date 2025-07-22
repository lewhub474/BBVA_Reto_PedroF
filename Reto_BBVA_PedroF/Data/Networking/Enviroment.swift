//
//  Enviroment.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

enum Environment {
    case development
    case staging
    case production

    var baseURL: URL? {
        switch self {
        case .development:
            return URL(string: "https://api.jsonbin.io/v3/b/687e9f36f7e7a370d1eb9ee0")
        case .staging:
            return URL(string: "https://api.jsonbin.io/v3/b/687e9f36f7e7a370d1eb9ee0")
        case .production:
            return URL(string: "https://api.jsonbin.io/v3/b/687e9f36f7e7a370d1eb9ee0")
        }
    }
}
