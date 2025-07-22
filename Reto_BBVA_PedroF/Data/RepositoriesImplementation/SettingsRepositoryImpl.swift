//
//  SettingsRepositoryImpl.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class SettingsRepositoryImpl: SettingsRepository {
    private let defaults = UserDefaults.standard
    private let key = "shouldHideAmounts"

    func getShouldHideAmounts() -> Bool {
        defaults.bool(forKey: key)
    }

    func setShouldHideAmounts(_ hidden: Bool) {
        defaults.set(hidden, forKey: key)
    }
}
