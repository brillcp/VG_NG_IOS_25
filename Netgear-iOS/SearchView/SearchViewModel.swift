//
//  BookSearchViewModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation

protocol SearchViewModelProtocol: ObservableObject {
    var books: [BookViewModel] { get }
    var isLoading: Bool { get }
    var query: String { get set }
    
    func search() async
}

// MARK: -
final class SearchViewModel {
    private let service = BookService()

    @Published var books: [BookViewModel] = []
    @Published var isLoading = false
    @Published var query = ""
}

// MARK: - SearchViewModelProtocol
extension SearchViewModel: SearchViewModelProtocol {
    @MainActor
    func search() async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        isLoading = true
        defer { isLoading = false }

        books = (try? await service.searchBooks(query: query)) ?? []
    }
}
