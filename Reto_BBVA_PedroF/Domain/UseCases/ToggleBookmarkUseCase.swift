//
//  ToggleBookmarkUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

final class ToggleBookmarkUseCase: UseCase {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository = BookmarkRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(_ id: Int) -> Any? {
        repository.toggleBookmark(id: id)
    }
}
