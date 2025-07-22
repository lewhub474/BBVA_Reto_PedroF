//
//  SetShouldHideAmountsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

final class SetShouldHideAmountsUseCase: UseCase {
    private let repository: SettingsRepository

    init(repository: SettingsRepository = SettingsRepositoryImpl()) {
        self.repository = repository
    }

    func execute(_ hidden: Bool) -> Any? {
        repository.setShouldHideAmounts(hidden)
    }
}
