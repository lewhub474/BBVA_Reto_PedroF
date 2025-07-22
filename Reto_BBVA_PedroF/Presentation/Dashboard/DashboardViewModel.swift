//
//  DashboardViewModel.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

import Foundation

final class DashboardViewModel {
    private(set) var balance: Double = 0.0
    private(set) var ingresos: Double = 0.0
    private(set) var egresos: Double = 0.0
    private(set) var sections: [TransactionSection] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    private(set) var shouldHideAmounts: Bool = false

    private(set) var bookmarkedIds: Set<Int> = []

    private let getTransactionsUseCase: any AsyncUseCase<Any?, Record>

    private let getShouldHideUseCase: any UseCase<Any?, Bool>
    private let setShouldHideUseCase: any UseCase<Bool, Any?>

    private let getAllBookmarksUseCase: any UseCase<Any?, [Int]>
    private let toggleBookmarkUseCase: any UseCase<Int, Any?>

    init(
        getTransactionsUseCase: any AsyncUseCase<Any?, Record> = GetTransactionsUseCase(),
        getShouldHideUseCase: any UseCase<Any?, Bool> = GetShouldHideAmountsUseCase(),
        setShouldHideUseCase: any UseCase<Bool, Any?> = SetShouldHideAmountsUseCase(),
        toggleBookmarkUseCase: any UseCase<Int, Any?> = ToggleBookmarkUseCase(),
        getAllBookmarksUseCase: any UseCase<Any?, [Int]> = GetAllBookmarksUseCase()
    ) {
        self.getTransactionsUseCase = getTransactionsUseCase
        self.getShouldHideUseCase = getShouldHideUseCase
        self.setShouldHideUseCase = setShouldHideUseCase
        self.toggleBookmarkUseCase = toggleBookmarkUseCase
        self.getAllBookmarksUseCase = getAllBookmarksUseCase
        self.shouldHideAmounts = getShouldHideUseCase.execute(nil)
        let bookMarkIds = getAllBookmarksUseCase.execute(nil).compactMap{ $0 }
        self.bookmarkedIds = Set(bookMarkIds)
    }

    
    func toggleBookmark(for id: Int) {
        toggleBookmarkUseCase.execute(id)
        refreshBookmarks()
    }

    func toggleHideAmounts(_ value: Bool) {
        shouldHideAmounts = value
        setShouldHideUseCase.execute(value)
    }

    func isBookmarked(_ id: Int) -> Bool {
        return bookmarkedIds.contains(id)
    }

    func fetchData() async {
        isLoading = true
        errorMessage = nil

        do {
            let record = try await getTransactionsUseCase.execute(nil)
            balance = record.balance

            let allTransactions = record.transactions
            ingresos = allTransactions
                .filter { $0.type == .income }
                .map { $0.amount }
                .reduce(0, +)

            egresos = allTransactions
                .filter { $0.type == .expense }
                .map { abs($0.amount) }
                .reduce(0, +)


            sections = allTransactions.groupedByDate()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func refreshBookmarks() {
        let bookMarkIds = getAllBookmarksUseCase.execute(nil)
            .compactMap{ $0 }
        self.bookmarkedIds = Set(bookMarkIds)
    }
}

