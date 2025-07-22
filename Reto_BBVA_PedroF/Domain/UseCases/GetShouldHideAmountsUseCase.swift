//
//  GetShouldHideAmountsUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//
import Foundation

final class GetShouldHideAmountsUseCase: UseCase {
    private let repository: SettingsRepository

    init(repository: SettingsRepository = SettingsRepositoryImpl()) {
        self.repository = repository
    }

    func execute(_ input: Any?) -> Bool {
        return repository.getShouldHideAmounts()
    }
}
