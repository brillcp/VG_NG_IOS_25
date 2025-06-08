//
//  BookViewModel.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import Foundation
import SwiftUI

@MainActor
protocol BookViewModelProtocol: ObservableObject, Identifiable {
    var id: String { get }
    var volumeInfo: VolumeInfo { get }
    var saleInfo: SaleInfo? { get }
    var searchInfo: SearchInfo? { get }
    var accessInfo: AccessInfo? { get }
    var color: Color { get }
    var priceString: String? { get }
    var imageData: Data? { get set }

    @Sendable
    func loadThumbnail() async
    func hapticFeedback()
}

// MARK: -
final class BookViewModel {
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    private let haptic = UIImpactFeedbackGenerator(style: .soft)
    private let session: URLSession
    private let book: Book

    @Published var imageData: Data?

    init(book: Book, session: URLSession = .shared) {
        self.session = session
        self.book = book
        haptic.prepare()
    }
}

// MARK: - BookViewModelProtocol
extension BookViewModel: BookViewModelProtocol {
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

    func hapticFeedback() {
        haptic.impactOccurred()
    }
}
