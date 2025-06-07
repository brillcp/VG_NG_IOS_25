//
//  BookViewModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation

final class BookViewModel: ObservableObject {
    private let session: URLSession
    private let book: Book

    @Published var imageData: Data?

    init(book: Book, session: URLSession = .shared) {
        self.session = session
        self.book = book
    }
}

// MARK: - Public properties
extension BookViewModel: Identifiable {
    var id: String { book.id }
    var volumeInfo: VolumeInfo { book.volumeInfo }
}

// MARK: - Public functions
@MainActor
extension BookViewModel {
    @Sendable
    func loadThumbnail() async {
        guard let url = volumeInfo.thumbnailURL else { return }
        do {
            let (data, _) = try await session.data(from: url)
            imageData = data
        } catch {
            print("Failed to load image data: \(error)")
        }
    }
}
