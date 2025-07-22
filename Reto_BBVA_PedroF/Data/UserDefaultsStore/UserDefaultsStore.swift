//
//  UserDefaultsCRUDStore.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

import Foundation

final class UserDefaultsStore<T: StorableItem> {

    private let storageKey: String
    private let keyValueStore: KeyValueStore
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        storageKey: String,
        keyValueStore: KeyValueStore = UserDefaults.standard,
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.storageKey = storageKey
        self.keyValueStore = keyValueStore
        self.encoder = encoder
        self.decoder = decoder
    }

    // MARK: - Save Entire List
    func save(_ items: [T]) {
        if let data = try? encoder.encode(items) {
            keyValueStore.set(data, forKey: storageKey)
            keyValueStore.synchronize()
        }
    }

    // MARK: - Get All
    func getAll() -> [T] {
        guard let data = keyValueStore.data(forKey: storageKey),
              let items = try? decoder.decode([T].self, from: data) else {
            return []
        }
        return items
    }

    // MARK: - Get by ID
    func get(by id: T.ID) -> T? {
        getAll().first { $0.id == id }
    }

    // MARK: - Add Item
    func add(_ item: T) {
        var items = getAll()
        items.append(item)
        save(items)
    }

    // MARK: - Update Item by ID
    func update(_ updatedItem: T) {
        var items = getAll()
        guard let index = items.firstIndex(where: { $0.id == updatedItem.id }) else { return }
        items[index] = updatedItem
        save(items)
    }

    // MARK: - Delete Item by ID
    func remove(by id: T.ID) {
        var items = getAll()
        items.removeAll { $0.id == id }
        save(items)
    }

    // MARK: - Delete All
    func clear() {
        keyValueStore.removeObject(forKey: storageKey)
    }
}
