//
//  BookService.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation
import Networking

protocol BookServiceProtocol {
    func searchBooks(query: String) async throws -> [BookViewModel]
}

// MARK: - Service Implementation
final class BookService {
    private let networkService: Network.Service

    init(baseURL: URL = .googleBookAPI) {
        let serverConfig = ServerConfig(baseURL: baseURL)
        self.networkService = Network.Service(server: serverConfig)
    }
}

// MARK: - BookServiceProtocol
extension BookService: BookServiceProtocol {
    @MainActor
    func searchBooks(query: String) async throws -> [BookViewModel] {
        let request = createSearchRequest(for: query)
        let response: BookResponse = try await performRequest(request)
        return mapToViewModels(response.items)
    }
}

// MARK: - Private Methods
private extension BookService {
    func createSearchRequest(for query: String) -> GoogleBookAPI {
        GoogleBookAPI.search(query: query)
    }

    func performRequest<T: Codable>(_ request: GoogleBookAPI) async throws -> T {
        try await networkService.request(request)
    }

    func mapToViewModels(_ books: [Book]) -> [BookViewModel] {
        books.map { BookViewModel(book: $0) }
    }
}
