//
//  BookSearchViewModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var books: [BookViewModel] { get }
    var isLoading: Bool { get }
    var query: String { get set }
    var hasSearched: Bool { get }
    var errorMessage: String? { get }

    func search() async
    func clearSearch()
}

// MARK: -
final class SearchViewModel {
    // MARK: Dependencies
    private let bookService: BookServiceProtocol

    // MARK: Published State
    @Published var books: [BookViewModel] = []
    @Published var isLoading = false
    @Published var query = ""
    @Published var hasSearched = false
    @Published var errorMessage: String?

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

    func clearSearch() {
        resetSearchState()
    }
}

// MARK: - Private Methods
private extension SearchViewModel {
    @MainActor
    func performSearch() async {
        guard isValidQuery else { return }

        prepareForSearch()

        do {
            let searchResults = try await bookService.searchBooks(query: trimmedQuery)
            handleSearchSuccess(searchResults)
        } catch {
            handleSearchError(error)
        }

        completeSearch()
    }
    
    func prepareForSearch() {
        isLoading = true
        errorMessage = nil
        books = []
    }

    func handleSearchSuccess(_ results: [BookViewModel]) {
        books = results
        hasSearched = true
    }

    func handleSearchError(_ error: Error) {
        errorMessage = "Failed to search books: \(error.localizedDescription)"
        books = []
        hasSearched = true
    }

    func completeSearch() {
        isLoading = false
    }

    func resetSearchState() {
        books = []
        hasSearched = false
        errorMessage = nil
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
