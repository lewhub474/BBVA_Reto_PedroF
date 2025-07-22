//
//  GetAllBookmarksUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

final class GetAllBookmarksUseCase: UseCase {
    private let repository: BookmarkRepository

    init(repository: BookmarkRepository = BookmarkRepositoryImpl()) {
        self.repository = repository
    }

    @discardableResult
    func execute(_ input: Any?) -> [Int] {
        return repository.getAllBookmarks()
            .map { $0.id }
    }
}
