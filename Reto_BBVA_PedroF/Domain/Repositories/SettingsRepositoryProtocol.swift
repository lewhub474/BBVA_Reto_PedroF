//
//  SettingsRepositoryProtocol.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

protocol SettingsRepository {
    func getShouldHideAmounts() -> Bool
    func setShouldHideAmounts(_ hidden: Bool)
}
