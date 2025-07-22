//
//  BookMarkRepository.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

protocol BookmarkRepository {
    func isBookmarked(id: Int) -> Bool
    func toggleBookmark(id: Int)
    func getAllBookmarks() -> [BookmarkDTO]
}
