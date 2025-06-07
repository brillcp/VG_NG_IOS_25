//
//  BookService.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation
import Networking

protocol BookServieProtocol {
    func searchBooks(query: String) async throws -> [BookViewModel]
    func downloadImage(url: URL) async throws -> Data
}

// MARK: -
final class BookService {
    private let service: Network.Service

    init(url: URL = .googleBookAPI) {
        let serverConfig: ServerConfig = .init(baseURL: url)
        self.service = .init(server: serverConfig)
    }
}

// MARK: - BookServieProtocol
extension BookService: BookServieProtocol {
    @MainActor
    func searchBooks(query: String) async throws -> [BookViewModel] {
        let request = GoogleBookAPI.search(query: query)
        let response: BookResponse = try await service.request(request)
        return response.items.map { BookViewModel(book: $0) }
    }

    func downloadImage(url: URL) async throws -> Data {
        let imageData = try Data(contentsOf: url)
        return imageData
    }
}
