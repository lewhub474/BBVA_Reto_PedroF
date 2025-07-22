//
//  SetShouldHideAmountsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

final class SetShouldHideAmountsUseCase {
    private let repository: SettingsRepository

    init(repository: SettingsRepository) {
        self.repository = repository
    }

    func execute(_ hidden: Bool) {
        repository.setShouldHideAmounts(hidden)
    }
}
