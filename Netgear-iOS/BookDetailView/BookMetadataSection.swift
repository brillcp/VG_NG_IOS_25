//
//  BookMetadataSection.swift
//  Netgear-iOS
//
//  Created by Viktor Gidlöf on 2025-06-07.
//

import SwiftUI

struct BookMetadataSection<ViewModel: BookViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            metadataLabels
            actionButtons
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundView)
    }
}

// MARK: - View Components
private extension BookMetadataSection {
    var metadataLabels: some View {
        HStack(spacing: 16) {
            languageLabel
            publishedDateLabel
            pageCountLabel
        }
    }

    @ViewBuilder
    var languageLabel: some View {
        if let language = volumeInfo.language {
            Label(language, systemImage: "character.book.closed.fill")
        }
    }

    @ViewBuilder
    var publishedDateLabel: some View {
        if let publishedDate = volumeInfo.publishedDate {
            Label(publishedDate, systemImage: "calendar")
        }
    }

    @ViewBuilder
    var pageCountLabel: some View {
        if let pageCount = volumeInfo.pageCount {
            Label("\(pageCount)", systemImage: "book.pages.fill")
        }
    }

    var actionButtons: some View {
        HStack {
            previewButton
            buyButton
        }
        .frame(maxWidth: .infinity)
    }

    var previewButton: some View {
        createNavigationLink(
            title: "Preview",
            url: viewModel.accessInfo?.webReaderLink
        )
        .buttonStyle(.bordered)
    }

    var buyButton: some View {
        createNavigationLink(
            title: buyButtonTitle,
            url: viewModel.saleInfo?.buyLink
        )
        .buttonStyle(.borderedProminent)
    }

    var backgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(backgroundOpacity)
    }
}

// MARK: - Computed Properties
private extension BookMetadataSection {
    var volumeInfo: VolumeInfo {
        viewModel.volumeInfo
    }

    var buyButtonTitle: String {
        if let priceString = viewModel.priceString {
            return "Buy \(priceString)"
        }
        return "Buy"
    }

    var backgroundOpacity: Color {
        let baseColor = viewModel.color.isDark ? Color.white : Color.black
        return baseColor.opacity(0.2)
    }
}

// MARK: - Helper Methods
private extension BookMetadataSection {
    func createNavigationLink(title: String, url: String?) -> some View {
        NavigationLink(destination: destinationView(for: url)) {
            buttonLabel(title: title)
        }
        .frame(maxWidth: .infinity)
        .disabled(url == nil)
    }

    @ViewBuilder
    func destinationView(for urlString: String?) -> some View {
        if let urlString = urlString,
           let url = URL(string: urlString) {
            WebView(url: url)
        } else {
            EmptyView()
        }
    }

    func buttonLabel(title: String) -> some View {
        HStack {
            Spacer()
            Text(title)
            Spacer()
        }
    }
}

#Preview {
    BookMetadataSection(viewModel: BookViewModel(book: .common))
}
