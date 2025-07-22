//
//  BookmarkRepositoryImpl.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

import Foundation

final class BookmarkRepositoryImpl: BookmarkRepository {
    private let store: UserDefaultsStore<BookmarkDTO>
    static var bookmarksKey: String { "bookmarks" }

    init(store: UserDefaultsStore<BookmarkDTO> = .init(storageKey: BookmarkRepositoryImpl.bookmarksKey)) {
        self.store = store
    }

    func isBookmarked(id: Int) -> Bool {
        return store.get(by: id) == nil
    }

    func toggleBookmark(id: Int) {

        if let bookmark = store.get(by: id) {
            store.remove(by: bookmark.id)
        } else {
            store.add(.init(id: id))
        }
    }


    func getAllBookmarks() -> [BookmarkDTO] {
        store.getAll()
    }
}
