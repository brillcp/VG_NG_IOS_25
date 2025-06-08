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
        VStack(spacing: 16) {
            metadataLabels
            actionButtons
        }
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
        if let language = viewModel.language {
            infoLabel(
                icon: "globe",
                title: language
            )
        }
    }

    @ViewBuilder
    var publishedDateLabel: some View {
        if let publishedDate = viewModel.publishedAt {
            infoLabel(
                icon: "calendar",
                title: publishedDate
            )
        }
    }

    @ViewBuilder
    var pageCountLabel: some View {
        if let pageCount = volumeInfo.pageCount {
            infoLabel(
                icon: "character.book.closed.fill",
                title: "\(pageCount) pages"
            )
        }
    }

    var actionButtons: some View {
        HStack(spacing: 16) {
            previewButton
            buyButton
        }
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
        RoundedRectangle(cornerRadius: 12.0)
            .fill(backgroundOpacity)
    }
    
    func infoLabel(icon: String, title: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
            Text(title)
                .font(.callout)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 84)
        .background(backgroundView)
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
        return baseColor.opacity(0.1)
    }
}

// MARK: - Helper Methods
private extension BookMetadataSection {
    func createNavigationLink(title: String, url: String?) -> some View {
        NavigationLink(destination: destinationView(for: url)) {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 34.0)
        }
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
}

#Preview {
    BookMetadataSection(viewModel: BookViewModel(book: .common))
}
