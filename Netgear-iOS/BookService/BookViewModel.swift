//
//  BookViewModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation
import SwiftUI

final class BookViewModel: ObservableObject {
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

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
    var saleInfo: SaleInfo? { book.saleInfo }
    var searchInfo: SearchInfo? { book.searchInfo }
    var accessInfo: AccessInfo? { book.accessInfo }

    var color: Color {
        guard let imageData, let color = UIImage(data: imageData)?.averageColor() else { return .black }
        return color
    }

    var priceString: String? {
        guard let saleInfo = saleInfo,
              let amount = saleInfo.retailPrice?.amount,
              let price = numberFormatter.string(from: .init(value: amount))
        else { return nil }
        return "\(price)"
    }
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
