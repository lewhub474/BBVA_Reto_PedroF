//
//  KeyValueStore.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

import Foundation

protocol KeyValueStore {
    func synchronize() -> Bool
    func data(forKey defaultName: String) -> Data?
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
}

extension UserDefaults: KeyValueStore {
}
