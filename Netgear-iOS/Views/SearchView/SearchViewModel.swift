//
//  BookSearchViewModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var searchState: SearchState { get set }
    var query: String { get set }

    func search() async
    func clearSearch(_ oldValue: String, _ newValue: String)
    func dismissError()
}

// MARK: - SearchViewModel
final class SearchViewModel {
    // MARK: Dependencies
    private let bookService: BookServiceProtocol

    // MARK: Published State
    @Published var searchState: SearchState = .idle
    @Published var query = ""

    // MARK: Initialization
    init(bookService: BookServiceProtocol = BookService()) {
        self.bookService = bookService
    }
}

// MARK: - SearchViewModelProtocol
extension SearchViewModel: SearchViewModelProtocol {
    func search() async {
        await performSearch()
    }

    func clearSearch(_ oldValue: String, _ newValue: String) {
        guard newValue.isEmpty else { return }
        resetSearchState()
    }

    func dismissError() {
        if case .failed = searchState {
            searchState = .idle
        }
    }
}

// MARK: - Private Methods
private extension SearchViewModel {
    @MainActor
    func performSearch() async {
        guard isValidQuery else { return }

        searchState = .searching

        do {
            let searchResults = try await bookService.searchBooks(query: trimmedQuery)
            searchState = .loaded(searchResults)
        } catch {
            searchState = .failed("Failed to search books: \(error.localizedDescription)")
        }
    }

    func resetSearchState() {
        searchState = .idle
        query = ""
    }
}

// MARK: - Computed Properties
private extension SearchViewModel {
    var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespaces)
    }

    var isValidQuery: Bool {
        !trimmedQuery.isEmpty
    }
}
