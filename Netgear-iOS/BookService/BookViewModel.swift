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
    var imageData: Data? { get }
    var language: String? { get }
    var publishedAt: String? { get }

    @Sendable
    func loadThumbnail() async
    func hapticFeedback()
}

// MARK: - ViewModel Implementation
final class BookViewModel {
    // MARK: Dependencies
    private let book: Book
    private let session: URLSession
    private let hapticGenerator: UIImpactFeedbackGenerator

    // MARK: State
    @Published var imageData: Data?

    // MARK: Initialization
    init(book: Book, session: URLSession = .shared) {
        self.book = book
        self.session = session
        self.hapticGenerator = UIImpactFeedbackGenerator(style: .soft)

        setupHapticGenerator()
    }
}

// MARK: - BookViewModelProtocol Conformance
extension BookViewModel: BookViewModelProtocol {
    // MARK: Book Properties
    var id: String { book.id }
    var volumeInfo: VolumeInfo { book.volumeInfo }
    var saleInfo: SaleInfo? { book.saleInfo }
    var searchInfo: SearchInfo? { book.searchInfo }
    var accessInfo: AccessInfo? { book.accessInfo }

    // MARK: Computed Properties
    var publishedAt: String? {
        guard let dateString = book.volumeInfo.publishedDate,
              let date = DateFormatters.iso8601.date(from: dateString)
        else { return nil }
        return DateFormatters.yearMonth.string(from: date)
    }

    var language: String? {
        guard let lang = book.volumeInfo.language,
              let locale = Locale(identifier: lang).localizedString(forLanguageCode: lang)?.capitalized
        else { return nil }
        return locale
    }

    var color: Color {
        extractDominantColor()
    }

    var priceString: String? {
        formatPrice()
    }

    // MARK: Actions
    func loadThumbnail() async {
        await loadImageData()
    }

    func hapticFeedback() {
        hapticGenerator.impactOccurred()
    }
}

// MARK: - Private Methods
private extension BookViewModel {
    func setupHapticGenerator() {
        hapticGenerator.prepare()
    }

    func extractDominantColor() -> Color {
        guard let imageData = imageData,
              let uiImage = UIImage(data: imageData),
              let averageColor = uiImage.averageColor() else {
            return .black
        }
        return averageColor
    }

    @MainActor
    func formatPrice() -> String? {
        guard let saleInfo = saleInfo,
              let amount = saleInfo.retailPrice?.amount
        else { return nil }
        return DateFormatters.price.string(from: NSNumber(value: amount))
    }

    @MainActor
    func loadImageData() async {
        guard let thumbnailURL = volumeInfo.thumbnailURL else { return }

        do {
            let (data, _) = try await session.data(from: thumbnailURL)
            imageData = data
        } catch {
            handleImageLoadError(error)
        }
    }

    func handleImageLoadError(_ error: Error) {
        print("Failed to load thumbnail image: \(error.localizedDescription)")
    }
}
