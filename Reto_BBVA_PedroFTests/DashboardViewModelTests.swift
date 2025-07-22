//
//  DashboardViewModelTests.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

import XCTest
@testable import Reto_BBVA_PedroF

final class DashboardViewModelTests: XCTestCase {
    var viewModel: DashboardViewModel!
    var getTransactionsUseCase: MockGetTransactionsUseCase!
    var getShouldHideUseCase: MockGetShouldHideAmountsUseCase!
    var setShouldHideUseCase: MockSetShouldHideAmountsUseCase!
    var toggleBookmarkUseCase: MockToggleBookmarkUseCase!
    var getAllBookmarksUseCase: MockGetAllBookmarksUseCase!

    override func setUp() {
        super.setUp()
        getTransactionsUseCase = MockGetTransactionsUseCase()
        getShouldHideUseCase = MockGetShouldHideAmountsUseCase()
        setShouldHideUseCase = MockSetShouldHideAmountsUseCase()
        toggleBookmarkUseCase = MockToggleBookmarkUseCase()
        getAllBookmarksUseCase = MockGetAllBookmarksUseCase()
        getAllBookmarksUseCase.bookmarked = [1, 2]

        viewModel = DashboardViewModel(
            getTransactionsUseCase: getTransactionsUseCase,
            getShouldHideUseCase: getShouldHideUseCase,
            setShouldHideUseCase: setShouldHideUseCase,
            toggleBookmarkUseCase: toggleBookmarkUseCase,
            getAllBookmarksUseCase: getAllBookmarksUseCase
        )
    }

    func testInit_ShouldSetInitialValuesFromUseCases() {
        XCTAssertEqual(viewModel.shouldHideAmounts, true)
        XCTAssertEqual(viewModel.bookmarkedIds, Set([1, 2]))
    }

    func testToggleBookmark_ShouldUpdateBookmarkedIds() {
        getAllBookmarksUseCase.bookmarked = [3, 4]
        viewModel.toggleBookmark(for: 3)

        XCTAssertTrue(toggleBookmarkUseCase.toggledIds.contains(3))
        XCTAssertEqual(viewModel.bookmarkedIds, Set([3, 4]))
    }

    func testToggleHideAmounts_ShouldUpdateAndCallUseCase() {
        viewModel.toggleHideAmounts(false)
        XCTAssertEqual(viewModel.shouldHideAmounts, false)
        XCTAssertEqual(setShouldHideUseCase.didSetValue, false)
    }

    func testIsBookmarked_ReturnsCorrectValue() {
        XCTAssertTrue(viewModel.isBookmarked(1))
        XCTAssertFalse(viewModel.isBookmarked(99))
    }

    func testFetchData_ShouldUpdateValuesCorrectly() async {
        getTransactionsUseCase.result = RecordStubs.createRecord()

        await viewModel.fetchData()

        XCTAssertEqual(viewModel.balance, RecordStubs.balance)
        XCTAssertEqual(viewModel.ingresos, 100.0)
        XCTAssertEqual(viewModel.egresos, 40.0)
        XCTAssertEqual(viewModel.sections.flatMap { $0.transactions }, transactions)
    }

    func testFetchData_WithError_ShouldSetErrorMessage() async {
        struct DummyError: Error, LocalizedError {
            var errorDescription: String? { "Test error" }
        }

        getTransactionsUseCase.result = .failure(DummyError())

        await viewModel.fetchData()

        XCTAssertEqual(viewModel.errorMessage, "Test error")
        XCTAssertEqual(viewModel.sections.count, 0)
    }
}
