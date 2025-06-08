//
//  BookCoverSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookCoverSection<ViewModel: BookViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(spacing: ViewMetrics.mainSpacing) {
            bookCoverImage
            bookInformationSection
        }
        .padding(ViewMetrics.cardPadding)
        .background(viewModel.color)
    }
}

// MARK: - View Components
private extension BookCoverSection {
    var bookCoverImage: some View {
        AsyncBookImage(viewModel: viewModel)
            .frame(
                width: ViewMetrics.coverWidth,
                height: ViewMetrics.coverHeight
            )
            .clipShape(RoundedRectangle.bookCornerRadius)
    }

    var bookInformationSection: some View {
        VStack(spacing: ViewMetrics.textSpacing) {
            primaryBookInfo
            BookMetadataSection(viewModel: viewModel)
                .padding(.top, ViewMetrics.metadataPaddingTop)
        }
        .foregroundStyle(adaptiveTextColor)
        .multilineTextAlignment(.center)
    }

    @ViewBuilder
    var primaryBookInfo: some View {
        bookTitle
        secondaryBookInfo

        if let author = primaryAuthor, let category = primaryCategory {
            authorCategoryText(author, category: category)
        }
    }

    @ViewBuilder
    var secondaryBookInfo: some View {
        if let subtitle = volumeInfo.subtitle {
            subtitleText(subtitle)
        }
    }

    var bookTitle: some View {
        Text(volumeInfo.title)
            .font(.title2.bold())
    }

    func authorCategoryText(_ author: String, category: String) -> some View {
        Text("\(author) · \(category)")
            .font(.body)
    }

    func subtitleText(_ subtitle: String) -> some View {
        Text(subtitle)
            .font(.caption.italic())
    }
}

// MARK: - Computed Properties
private extension BookCoverSection {
    var volumeInfo: VolumeInfo {
        viewModel.volumeInfo
    }

    var primaryAuthor: String? {
        volumeInfo.authors?.first
    }

    var primaryCategory: String? {
        volumeInfo.categories?.first
    }

    var adaptiveTextColor: Color {
        viewModel.color.isDark ? .white : .black
    }
}

// MARK: - View Metrics
private enum ViewMetrics {
    // MARK: Spacing
    static let mainSpacing: CGFloat = 16
    static let textSpacing: CGFloat = 8
    static let metadataPaddingTop: CGFloat = 8

    // MARK: Padding
    static let cardPadding: CGFloat = 16

    // MARK: Cover Image Dimensions
    static let coverWidth: CGFloat = 160
    static let coverHeight: CGFloat = 240
}

#Preview {
    BookCoverSection(viewModel: BookViewModel(book: .common))
}
